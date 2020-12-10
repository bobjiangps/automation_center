from .models import Project, Script, AutomatedCase
from rest_framework import serializers
from django.contrib.auth.models import User


# class ProjectSerializer(serializers.Serializer):
#     id = serializers.IntegerField(read_only=True)
#     name = serializers.CharField(max_length=100)
#     create_time = serializers.DateTimeField()
#     update_time = serializers.DateTimeField()
#
#     def create(self, validated_data):
#         """
#         Create and return a new `project` instance, given the validated data.
#         """
#         return Project.objects.create(**validated_data)
#
#     def update(self, instance, validated_data):
#         """
#         Update and return an existing `project` instance, given the validated data.
#         """
#         instance.name = validated_data.get('name', instance.name)
#         instance.create_time = validated_data.get('create_time', instance.create_time)
#         instance.update_time = validated_data.get('update_time', instance.update_time)
#         instance.save()
#         return instance


# class ProjectSerializer(serializers.ModelSerializer):
#     # owner = OwnerSerializer(read_only=True, many=True)
#     owner_info = serializers.SerializerMethodField()
#
#     def get_owner_info(self, instance):
#         user_obj = instance.owner.get_queryset()
#         owner_list = []
#         if user_obj:
#             for u in user_obj:
#                 owner_list.append({"id": u.id,
#                                    "user_name": u.username,
#                                    "last_login": u.last_login,
#                                    "email": u.email})
#         return owner_list
#
#     class Meta:
#         model = Project
#         fields = "__all__"
#         # fields = ("id", "name", "project_type", "create_time", "update_time", "owner")


class ProjectSerializer(serializers.ModelSerializer):

    class Meta:
        model = Project
        fields = "__all__"

    # def to_representation(self, instance):
    #     response = super().to_representation(instance)
    #     response['owner'] = OwnerSerializer(instance.owner, many=True).data
    #     return response


class OwnerSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ["id", "username", "email"]


class ScriptSerializer(serializers.ModelSerializer):

    class Meta:
        model = Script
        fields = "__all__"


class AutomationCaseSerializer(serializers.ModelSerializer):

    class Meta:
        model = AutomatedCase
        fields = "__all__"
