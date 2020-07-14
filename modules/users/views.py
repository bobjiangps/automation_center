from django.contrib.auth.models import User, Group, Permission
from rest_framework import viewsets
from .serializers import UserSerializer, GroupSerializer, PermissionSerializer
from utils.permission import IsSuperUserOrReadOnly
from django.utils import timezone
from django.apps import apps
from django.conf import settings
from rest_framework import status
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
import datetime


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
    permission_classes = [IsSuperUserOrReadOnly]
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer


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
    permission_classes = [IsSuperUserOrReadOnly]
    queryset = Group.objects.all().order_by('id')
    serializer_class = GroupSerializer


class PermissionViewSet(viewsets.ReadOnlyModelViewSet):
    """
        get:
            Return all permissions.
    """
    queryset = Permission.objects.all().order_by('id')
    serializer_class = PermissionSerializer


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
                                 "token": token.key,
                                 "permissions": self.list_perms(user)})
            else:
                return Response({"token": token.key})
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @staticmethod
    def list_perms(user):
        exclude_list = ["token", "contenttype", "session", "logentry", "permission"]
        user_perms_dict = {}
        user_perms_list = []
        for am in apps.get_models():
            name = am.__name__.lower()
            if name not in exclude_list:
                user_perms_dict[name] = ["view"]
                user_perms_list.append(name)
        default_all_perms = user.get_all_permissions()
        for perm in default_all_perms:
            new_perm = perm.split(".")[-1]
            action, module = new_perm.split("_")
            if action == "delete" and module == "project":
                continue
            if module not in exclude_list:
                if module in user_perms_list:
                    if action not in user_perms_dict[module]:
                        user_perms_dict[module].append(action)
                else:
                    user_perms_dict[module] = [action]
                    user_perms_list.append(module)
        for d in user_perms_dict.keys():
            user_perms_dict[d].sort()
        return user_perms_dict
