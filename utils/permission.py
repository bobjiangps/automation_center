from rest_framework.permissions import BasePermission
from projects.models import Project


SAFE_METHODS = ('GET', 'HEAD', 'OPTIONS')


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
