from .models import Project, Script, AutomatedCase, TestSuite, ScriptFunction, TestRound
from rest_framework import serializers
from django.contrib.auth.models import User
from modules.execution.models import TestEnvironment


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


class TestSuiteSerializer(serializers.ModelSerializer):

    def validate_script(self, value):
        script_match_project = True
        project = self.context['request'].data["project"][0]
        for v in value:
            if v.project_id != int(project):
                script_match_project = False
                break
        if script_match_project:
            return value
        else:
            raise serializers.ValidationError("Cannot select scripts from another project")

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response["script_amount"] = len(response["script"])
        script_functions = ScriptFunction.objects.filter(script__in=response["script"])
        automated_cases = AutomatedCase.objects.filter(script_function__in=script_functions)
        response["case_amount"] = len(automated_cases)
        return response

    class Meta:
        model = TestSuite
        fields = "__all__"


class TestRoundSerializer(serializers.ModelSerializer):

    class Meta:
        model = TestRound
        fields = "__all__"

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['creator'] = instance.creator.username
        response["test_environment"] = instance.test_environment.name
        return response
