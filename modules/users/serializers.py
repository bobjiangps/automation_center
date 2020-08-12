from django.contrib.auth.models import User, Group, Permission
from django.contrib.auth import get_user_model
from rest_framework import serializers


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


class OwnerSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ["id", "username", "email"]


class GroupSerializer(serializers.ModelSerializer):

    class Meta:
        model = Group
        fields = "__all__"


class PermissionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Permission
        fields = "__all__"
