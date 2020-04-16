from django.contrib.auth.models import User, Group, Permission
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
    # if use HyperlinkedModelSerializer, then show url for user_permissions

    class Meta:
        model = User
        fields = ["id", "username", "email", "is_active", "is_staff", "is_superuser", "groups", "last_login", "user_permissions"]


class GroupSerializer(serializers.ModelSerializer):

    class Meta:
        model = Group
        fields = "__all__"


class PermissionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Permission
        fields = "__all__"
