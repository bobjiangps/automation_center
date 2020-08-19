from django.contrib.auth.models import User, Group
from django.apps import apps
from django.conf import settings
from rest_framework import status
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.views import APIView
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.permissions import IsAuthenticated
from modules.users.models import Role
import datetime


class ObtainExpiringAuthToken(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        if serializer.is_valid(raise_exception=True):
            user = serializer.validated_data['user']
            token, created = Token.objects.get_or_create(user=user)
            if request.path_info.find("/logout/") > 0:
                token.delete()
                return Response({"token": "deleted"})

            # utc_now = datetime.datetime.utcnow().replace(tzinfo=timezone.utc)
            now = datetime.datetime.now()
            if not created:
                if token.created < now - datetime.timedelta(hours=settings.EXPIRE_HOURS):
                    print("re-generate token for old one is expired")
                    token.delete()
                    token = Token.objects.create(user=user)
                    token.created = datetime.datetime.now()
                    token.save()
                else:
                    token.created = datetime.datetime.now()
                    token.save()
            if request.path_info.find("/login/") > 0:
                return Response({"id": user.pk,
                                 "username": user.username,
                                 "mail": user.email,
                                 "token": token.key})
            else:
                return Response({"token": token.key})
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @staticmethod
    def list_perms(user, project_id=None):
        exclude_list = ["token", "contenttype", "session", "logentry"]
        readonly_list = ["permission"]
        user_perms_dict = {}
        user_perms_list = []
        for am in apps.get_models():
            name = am.__name__.lower()
            if name not in exclude_list:
                # user_perms_dict[name] = ["view"]
                user_perms_dict[name] = ["read"]
                user_perms_list.append(name)
        default_all_perms = user.get_all_permissions()
        user_groups = []
        non_business_all_perms = set()
        for r in Role.objects.filter(user_id=user.id):
            if r.group not in user_groups:
                user_groups.append(r.group)
        for group in set(user_groups):
            for p in group.permissions.all():
                nk = p.natural_key()
                if nk[1] in ["users", "auth"] or nk[0] == "add_project":
                    non_business_all_perms.add(".".join([nk[1], nk[0]]))
        default_all_perms.update(non_business_all_perms)
        if project_id:
            user_role = Role.objects.filter(user_id=user.id).filter(project_id=project_id)
            user_permission_in_project = False
            for ur in user_role:
                if user_permission_in_project:
                    user_permission_in_project = user_permission_in_project | Group.objects.filter(id=ur.group_id)[0].permissions.all()
                else:
                    user_permission_in_project = Group.objects.filter(id=ur.group_id)[0].permissions.all()
            if user_permission_in_project:
                project_all_perms = set()
                for upp in user_permission_in_project:
                    nk = upp.natural_key()
                    project_all_perms.add(".".join([nk[1], nk[0]]))
                default_all_perms.update(project_all_perms)
        for perm in default_all_perms:
            new_perm = perm.split(".")[-1]
            action, module = new_perm.split("_")
            action_new_name = {"add": "create",
                               "change": "update",
                               "view": "read"}
            if action == "delete" and module == "project":
                continue
            if action in action_new_name.keys():
                action = action_new_name[action]
            if module not in exclude_list and module not in readonly_list:
                if module in user_perms_list:
                    if action not in user_perms_dict[module]:
                        user_perms_dict[module].append(action)
                else:
                    user_perms_dict[module] = [action]
                    user_perms_list.append(module)
        for d in user_perms_dict.keys():
            user_perms_dict[d].sort()
        return user_perms_dict


class RevokeAuthToken(APIView):
    queryset = User.objects.none()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            request.user.auth_token.delete()
        except (AttributeError, ObjectDoesNotExist):
            pass
        return Response({"result": "Successfully logged out."}, status=status.HTTP_200_OK)
