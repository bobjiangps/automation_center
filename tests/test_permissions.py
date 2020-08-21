import json
from rest_framework import status
from rest_framework.test import APITestCase
from django.contrib.auth.models import User, Permission


class PermissionTest(APITestCase):

    def setUp(self):
        self.super_user_data = {
            "username": "su",
            "email": "su@test.com",
            "password": "123456"
        }
        self.super_user = User.objects.create_superuser(username=self.super_user_data["username"], email=self.super_user_data["email"], password=self.super_user_data["password"])
        user_response = json.loads(self.client.post("/automation/api/login/", self.super_user_data, format="json").content)
        self.su_token = user_response["token"]
        self.su_user_id = user_response["id"]

        self.user1_data = {
            "username": "user1",
            "password": "111111"
        }
        self.user1 = User.objects.create_user(username=self.user1_data["username"], password=self.user1_data["password"])
        user_response = json.loads(self.client.post("/automation/api/login/", self.user1_data, format="json").content)
        self.user1_token = user_response["token"]
        self.user1_id = user_response["id"]

        self.user2_data = {
            "username": "user2",
            "password": "111111"
        }
        self.user2 = User.objects.create_user(username=self.user2_data["username"], password=self.user2_data["password"])
        user_response = json.loads(self.client.post("/automation/api/login/", self.user2_data, format="json").content)
        self.user2_token = user_response["token"]
        self.user2_id = user_response["id"]

        self.temp_user_data = {
            "username": "temp_no_role",
            "password": "111111"
        }
        self.temp_user = User.objects.create_user(username=self.temp_user_data["username"], password=self.temp_user_data["password"])
        user_response = json.loads(self.client.post("/automation/api/login/", self.temp_user_data, format="json").content)
        self.temp_token = user_response["token"]
        self.temp_id = user_response["id"]

        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.su_token)

        self.project_url = "/automation/api/projects/"
        self.project1_data = {
            "name": "project1",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.project1_id = json.loads(self.client.post(self.project_url, self.project1_data, format="json").content)["id"]
        self.project2_data = {
            "name": "project2",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.project2_id = json.loads(self.client.post(self.project_url, self.project2_data, format="json").content)["id"]

        self.group_url = "/automation/api/groups/"
        self.role_url = "/automation/api/roles/"
        group_leader = {
            "name": "leader",
            "permissions": [
                "view_project",
                "add_project",
                "change_project",
                "delete_project"
            ]
        }
        group_tester = {
            "name": "tester",
            "permissions": [
                "view_project"
            ]
        }
        self.all_permissions = Permission.objects.all()
        leader_group_permissions = []
        tester_group_permissions = []
        for ap in self.all_permissions:
            if ap.codename in group_leader["permissions"]:
                leader_group_permissions.append(ap.id)
            elif ap.codename in group_tester["permissions"]:
                tester_group_permissions.append(ap.id)
        self.leader_group_id = json.loads(self.client.post(self.group_url, {"name": group_leader["name"], "permissions": leader_group_permissions}, format="json").content)["id"]
        self.client.post(self.role_url, {"group": self.leader_group_id, "project": self.project1_id, "user": self.user1_id}, format="json")
        self.tester_group_id = json.loads(self.client.post(self.group_url, {"name": group_tester["name"], "permissions": tester_group_permissions}, format="json").content)["id"]
        self.client.post(self.role_url, {"group": self.tester_group_id, "project": self.project2_id, "user": self.user2_id}, format="json")

    def test_no_view_project_permission_can_get_project_list(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.temp_token)
        response = self.client.get(self.project_url, format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        response_results = json.loads(response.content)["results"]
        self.assertEqual(len(response_results), 2)

    def test_has_view_project_permission_can_get_list(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
        response = self.client.get(self.project_url, format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        response_results = json.loads(response.content)["results"]
        self.assertEqual(len(response_results), 2)

    def test_no_add_project_permission_cannot_create_project(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user2_token)
        response = self.client.post(self.project_url, {"name": "project_cannot_create"}, format="json")
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_has_add_project_permission_can_create_project(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
        new_project_data = {"name": "project_create_by_admin"}
        create_project_response = self.client.post(self.project_url, new_project_data, format="json")
        self.assertEqual(create_project_response.status_code, status.HTTP_201_CREATED)
        response_results = json.loads(self.client.get(self.project_url, format="json").content)["results"]
        self.assertEqual(len(response_results), 3)

    def test_no_change_project_permission_cannot_update_project(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user2_token)
        response = self.client.put(f"{self.project_url}{self.project2_id}/", {"create_time": "2019-12-25T00:58:00Z"}, format="json")
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_has_change_project_permission_can_update_project(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
        new_date = {"create_time": "2019-12-25T00:58:00"}
        response_results = json.loads(self.client.get(self.project_url, format="json").content)["results"]
        self.assertNotEqual(response_results[0]["create_time"], new_date["create_time"])
        self.client.patch(f"{self.project_url}{self.project1_id}/", new_date, format="json")
        response_results = json.loads(self.client.get(self.project_url, format="json").content)["results"]
        self.assertEqual(response_results[-1]["create_time"], new_date["create_time"])

    def test_not_allow_to_delete_project(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
        response = self.client.delete(f"{self.project_url}{self.project1_id}/", format="json")
        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)


# # if open the get_queryset function in module project list and use 'user_perms_dict[name] = []' (not allow read as default) in list_perms function; use the following unit tests
# class PermissionTest(APITestCase):
#
#     def setUp(self):
#         self.super_user_data = {
#             "username": "su",
#             "email": "su@test.com",
#             "password": "123456"
#         }
#         self.super_user = User.objects.create_superuser(username=self.super_user_data["username"], email=self.super_user_data["email"], password=self.super_user_data["password"])
#         user_response = json.loads(self.client.post("/automation/api/login/", self.super_user_data, format="json").content)
#         self.su_token = user_response["token"]
#         self.su_user_id = user_response["id"]
#
#         self.user1_data = {
#             "username": "user1",
#             "password": "111111"
#         }
#         self.user1 = User.objects.create_user(username=self.user1_data["username"], password=self.user1_data["password"])
#         user_response = json.loads(self.client.post("/automation/api/login/", self.user1_data, format="json").content)
#         self.user1_token = user_response["token"]
#         self.user1_id = user_response["id"]
#
#         self.user2_data = {
#             "username": "user2",
#             "password": "111111"
#         }
#         self.user2 = User.objects.create_user(username=self.user2_data["username"], password=self.user2_data["password"])
#         user_response = json.loads(self.client.post("/automation/api/login/", self.user2_data, format="json").content)
#         self.user2_token = user_response["token"]
#         self.user2_id = user_response["id"]
#
#         self.temp_user_data = {
#             "username": "temp_no_role",
#             "password": "111111"
#         }
#         self.temp_user = User.objects.create_user(username=self.temp_user_data["username"], password=self.temp_user_data["password"])
#         user_response = json.loads(self.client.post("/automation/api/login/", self.temp_user_data, format="json").content)
#         self.temp_token = user_response["token"]
#         self.temp_id = user_response["id"]
#
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.su_token)
#
#         self.project_url = "/automation/api/projects/"
#         self.project1_data = {
#             "name": "project1",
#             "create_time": "2019-12-22T00:58:00",
#             "update_time": "2019-12-23T00:59:00"
#         }
#         self.project1_id = json.loads(self.client.post(self.project_url, self.project1_data, format="json").content)["id"]
#         self.project2_data = {
#             "name": "project2",
#             "create_time": "2019-12-22T00:58:00",
#             "update_time": "2019-12-23T00:59:00"
#         }
#         self.project2_id = json.loads(self.client.post(self.project_url, self.project2_data, format="json").content)["id"]
#
#         self.group_url = "/automation/api/groups/"
#         self.role_url = "/automation/api/roles/"
#         group_leader = {
#             "name": "leader",
#             "permissions": [
#                 "view_project",
#                 "add_project",
#                 "change_project",
#                 "delete_project"
#             ]
#         }
#         group_tester = {
#             "name": "tester",
#             "permissions": [
#                 "view_project"
#             ]
#         }
#         self.all_permissions = Permission.objects.all()
#         leader_group_permissions = []
#         tester_group_permissions = []
#         for ap in self.all_permissions:
#             if ap.codename in group_leader["permissions"]:
#                 leader_group_permissions.append(ap.id)
#             elif ap.codename in group_tester["permissions"]:
#                 tester_group_permissions.append(ap.id)
#         self.leader_group_id = json.loads(self.client.post(self.group_url, {"name": group_leader["name"], "permissions": leader_group_permissions}, format="json").content)["id"]
#         self.client.post(self.role_url, {"group": self.leader_group_id, "project": self.project1_id, "user": self.user1_id}, format="json")
#         self.tester_group_id = json.loads(self.client.post(self.group_url, {"name": group_tester["name"], "permissions": tester_group_permissions}, format="json").content)["id"]
#         self.client.post(self.role_url, {"group": self.tester_group_id, "project": self.project2_id, "user": self.user2_id}, format="json")
#
#     def test_no_view_project_permission_cannot_get_project_list(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.temp_token)
#         response = self.client.get(self.project_url, format="json")
#         self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
#
#     def test_has_view_project_permission_can_get_list_of_specified_project(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
#         response = self.client.get(self.project_url, format="json")
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#         response_results = json.loads(response.content)["results"]
#         self.assertEqual(len(response_results), 1)
#         self.assertEqual(response_results[0]["name"], self.project1_data["name"])
#
#     def test_no_add_project_permission_cannot_create_project(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user2_token)
#         response = self.client.post(self.project_url, {"name": "project_cannot_create"}, format="json")
#         self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
#
#     def test_has_add_project_permission_can_create_project(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
#         new_project_data = {"name": "project_create_by_admin"}
#         create_project_response = self.client.post(self.project_url, new_project_data, format="json")
#         self.assertEqual(create_project_response.status_code, status.HTTP_201_CREATED)
#         response_results = json.loads(self.client.get(self.project_url, format="json").content)["results"]
#         self.assertEqual(len(response_results), 1)
#         self.assertEqual(response_results[0]["name"], self.project1_data["name"])
#
#     def test_no_change_project_permission_cannot_update_project(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user2_token)
#         response = self.client.put(f"{self.project_url}{self.project2_id}/", {"create_time": "2019-12-25T00:58:00Z"}, format="json")
#         self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
#
#     def test_has_change_project_permission_can_update_project(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
#         new_date = {"create_time": "2019-12-25T00:58:00"}
#         response_results = json.loads(self.client.get(self.project_url, format="json").content)["results"]
#         self.assertNotEqual(response_results[0]["create_time"], new_date["create_time"])
#         self.client.patch(f"{self.project_url}{self.project1_id}/", new_date, format="json")
#         response_results = json.loads(self.client.get(self.project_url, format="json").content)["results"]
#         self.assertEqual(response_results[0]["create_time"], new_date["create_time"])
#
#     def test_not_allow_to_delete_project(self):
#         self.client.credentials(HTTP_AUTHORIZATION="Token " + self.user1_token)
#         response = self.client.delete(f"{self.project_url}{self.project1_id}/", format="json")
#         self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
