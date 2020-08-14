from django.contrib.auth.models import User, Group, Permission
from django.contrib.auth import get_user_model
from rest_framework import serializers
from modules.users.models import Role
from modules.projects.serializers import ProjectSerializer


class UserSerializer(serializers.ModelSerializer):
    # if use HyperlinkedModelSerializer, then show url for user_permissions

    class Meta:
        model = User
        fields = ["id", "username", "email", "password", "is_active", "is_staff", "is_superuser", "groups", "last_login"]
        extra_kwargs = {"password": {"write_only": True}}

    def create(self, validated_data):
        user = get_user_model().objects.create_user(**validated_data)
        return user

    # this following annotation is another available method to create user by api
    # def create(self, validated_data):
    #     user = User(**validated_data)
    #     # Hash the user's password.
    #     user.set_password(validated_data['password'])
    #     user.save()
    #     return user

    def update(self, instance, validated_data):
        if "password" in validated_data:
            password = validated_data.pop("password")
            instance.set_password(password)
        return super(UserSerializer, self).update(instance, validated_data)


class GroupSerializer(serializers.ModelSerializer):

    class Meta:
        model = Group
        fields = "__all__"


class RoleSerializer(serializers.ModelSerializer):

    class Meta:
        model = Role
        fields = "__all__"

    def to_representation(self, instance):
        response = super().to_representation(instance)
        group_data = GroupSerializer(instance.group).data
        project_data = ProjectSerializer(instance.project).data
        user_data = UserSerializer(instance.user).data
        response['group'] = {"id": group_data["id"], "name": group_data["name"]}
        response['project'] = {"id": project_data["id"], "name": project_data["name"]}
        response['user'] = {"id": user_data["id"], "username": user_data["username"], "email": user_data["email"]}
        return response


class PermissionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Permission
        fields = "__all__"
