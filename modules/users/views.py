from django.contrib.auth.models import User, Group, Permission
from rest_framework import viewsets
from .serializers import UserSerializer, GroupSerializer, PermissionSerializer
# from utils.permission import IsSuperUserOrReadOnly
from django.utils import timezone
from django.apps import apps
from django.conf import settings
from rest_framework import status
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.views import APIView
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.permissions import IsAuthenticated
from rest_framework import filters
import datetime
from modules.projects.models import Project


class UserViewSet(viewsets.ModelViewSet):
    """
        get:
            Return all users.

        post:
            Create a new user.

        put:
            Update a user.

        patch:
            Update one or more fields on an existing user.

        delete:
            Delete existing user.
    """
    # permission_classes = [IsSuperUserOrReadOnly]
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["username", "email"]


class GroupViewSet(viewsets.ModelViewSet):
    """
        get:
            Return all groups.

        post:
            Create a new group.

        put:
            Update a group.

        patch:
            Update one or more fields on an existing group.

        delete:
            Delete existing group.
    """
    # permission_classes = [IsSuperUserOrReadOnly]
    queryset = Group.objects.all().order_by('id')
    serializer_class = GroupSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["name"]


class PermissionViewSet(viewsets.ReadOnlyModelViewSet):
    """
        get:
            Return all permissions.
    """
    # permission_classes = [IsSuperUserOrReadOnly]
    queryset = Permission.objects.all().order_by('id')
    serializer_class = PermissionSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["name", "codename"]


class CurrentUser(APIView):
    queryset = User.objects.none()

    def get(self, request):
        current_user = request.user
        if current_user.is_authenticated:
            project_id = self.request.query_params.get("project_id", None)
            in_admin = False
            for g in current_user.groups.all():
                if g.name == "Admin":
                    in_admin = True
                    break
            serializer = UserSerializer(current_user)
            if project_id:
                project = Project.objects.filter(id=project_id)
                if len(project) > 0:
                    return Response({"id": serializer.data["id"],
                                     "username": serializer.data["username"],
                                     "email": serializer.data["email"],
                                     "admin": current_user.is_superuser or in_admin,
                                     "project": project[0].name,
                                     "permissions": ObtainExpiringAuthToken.list_perms(current_user)
                                     })
                else:
                    return Response({"error": "project not exist"})
            else:
                return Response({"id": serializer.data["id"],
                                 "username": serializer.data["username"],
                                 "email": serializer.data["email"],
                                 "admin": current_user.is_superuser or in_admin,
                                 "project": None,
                                 "permissions": ObtainExpiringAuthToken.list_perms(current_user)
                                 })
        else:
            return Response({"error": "not authenticated"})


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
    def list_perms(user):
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
