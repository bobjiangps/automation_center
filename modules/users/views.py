from django.contrib.auth.models import User, Group, Permission
from rest_framework import viewsets
from .serializers import UserSerializer, GroupSerializer, RoleSerializer, PermissionSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import filters
from modules.projects.models import Project
from modules.users.models import Role
from modules.users.views_auth_token import ObtainExpiringAuthToken
from utils.permission import HasAssignedPermission


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
    permission_classes = [HasAssignedPermission]
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
    permission_classes = [HasAssignedPermission]
    queryset = Group.objects.all().order_by('-id')
    serializer_class = GroupSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["name"]


class RoleViewSet(viewsets.ModelViewSet):
    """
        get:
            Return all roles.

        post:
            Create a new role.

        put:
            Update a role.

        patch:
            Update one or more fields on an existing role.

        delete:
            Delete existing role.
    """
    permission_classes = [HasAssignedPermission]
    queryset = Role.objects.all().order_by('-id')
    serializer_class = RoleSerializer


class PermissionViewSet(viewsets.ReadOnlyModelViewSet):
    """
        get:
            Return all permissions.
    """
    # permission_classes = [IsSuperUserOrReadOnly]
    permission_classes = [HasAssignedPermission]
    queryset = Permission.objects.all().order_by('-id')
    serializer_class = PermissionSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["name", "codename"]


class CurrentUser(APIView):
    queryset = User.objects.none()

    def get(self, request):
        current_user = request.user
        if current_user.is_authenticated:
            project_id = self.request.query_params.get("project_id", None)
            serializer = UserSerializer(current_user)
            if project_id:
                project = Project.objects.filter(id=project_id)
                if len(project) > 0:
                    return Response({"id": serializer.data["id"],
                                     "username": serializer.data["username"],
                                     "email": serializer.data["email"],
                                     "project": project[0].name,
                                     "permissions": ObtainExpiringAuthToken.list_perms(current_user, project_id=project_id)
                                     })
                else:
                    return Response({"error": "project not exist"})
            else:
                return Response({"id": serializer.data["id"],
                                 "username": serializer.data["username"],
                                 "email": serializer.data["email"],
                                 "project": None,
                                 "permissions": ObtainExpiringAuthToken.list_perms(current_user)
                                 })
        else:
            return Response({"error": "not authenticated"})
