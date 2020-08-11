from rest_framework.permissions import BasePermission
from rest_framework.permissions import DjangoModelPermissions
from modules.users.views import ObtainExpiringAuthToken
from modules.projects.models import Project


SAFE_METHODS = ('GET', 'HEAD', 'OPTIONS')
METHODS_RELATIONS = {
    "GET": "read",
    "HEAD": "read",
    "OPTIONS": "read",
    "POST": "create",
    "PUT": "update",
    "PATCH": "update",
    "DELETE": "delete"
}


class ReadOnly(BasePermission):
    """
    Only allow read requests.
    """

    def has_permission(self, request, view):
        return bool(request.method in SAFE_METHODS)


class IsStaffUser(BasePermission):
    """
    Allows access only to staff or super users.
    """

    def has_permission(self, request, view):
        return bool(request.user and
                    request.user.is_staff or
                    request.user.is_superuser)


class IsStaffUserOrReadOnly(BasePermission):
    """
    The request is authenticated as a staff or super user, or is a read-only request.
    """

    def has_permission(self, request, view):
        return bool(
            request.method in SAFE_METHODS or
            request.user and
            request.user.is_staff or
            request.user.is_superuser
        )


class IsSuperUser(BasePermission):
    """
    Allows access only to super users.
    """

    def has_permission(self, request, view):
        return bool(request.user and request.user.is_superuser)


class IsSuperUserOrReadOnly(BasePermission):
    """
    The request is authenticated as a super user, or is a read-only request.
    """

    def has_permission(self, request, view):
        return bool(
            request.method in SAFE_METHODS or
            request.user and
            request.user.is_superuser
        )


class IsSpecifiedProjectOrReadOnly(BasePermission):
    """
    The request user is authenticated to specified project, or super user, or is a read-only request.
    """

    def has_object_permission(self, request, view, obj):
        if obj._meta.object_name == "Project":
            project_id = obj.id
        else:
            project_id = obj.project_id
        allow_owners = []
        for o in Project.objects.filter(id=project_id)[0].owner.values():
            allow_owners.append(o["id"])

        return bool(
            request.method in SAFE_METHODS or
            request.user and
            request.user.id in allow_owners or
            request.user.is_superuser
        )


class IsSpecifiedProject(BasePermission):
    """
    The request user is authenticated to specified project and user has corresponding permission like read/update,
    or super user, not allow read-only request.
    """

    def has_object_permission(self, request, view, obj):
        if obj._meta.object_name == "Project":
            project_id = obj.id
        else:
            project_id = obj.project_id
        allow_owners = []
        for o in Project.objects.filter(id=project_id)[0].owner.values():
            allow_owners.append(o["id"])
        method_allowed = False
        user_permission = ObtainExpiringAuthToken.list_perms(request.user)[obj._meta.object_name.lower()]
        if METHODS_RELATIONS[request.method] in user_permission:
            method_allowed = True

        return bool(
            request.user and
            request.user.id in allow_owners and
            method_allowed or
            request.user.is_superuser
        )


class DjangoModelPermissionsWithRead(DjangoModelPermissions):
    perms_map = {
        'GET': ['%(app_label)s.view_%(model_name)s'],
        'OPTIONS': [],
        'HEAD': [],
        'POST': ['%(app_label)s.add_%(model_name)s'],
        'PUT': ['%(app_label)s.change_%(model_name)s'],
        'PATCH': ['%(app_label)s.change_%(model_name)s'],
        'DELETE': ['%(app_label)s.delete_%(model_name)s'],
    }
