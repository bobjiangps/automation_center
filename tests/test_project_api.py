import json
from django.test import TestCase
from rest_framework import status
from rest_framework.test import APIClient
from rest_framework.test import APITestCase
from django.contrib.auth.models import User


class ProjectListTest(APITestCase):

    def setUp(self):
        self.admin_data = {
            "username": "admin",
            "email": "admin@test.com",
            "password": "123456"
        }
        self.admin = User.objects.create_superuser(username=self.admin_data["username"], email=self.admin_data["email"], password=self.admin_data["password"])
        self.admin_token = json.loads(self.client.post("/automation/api/api-token-auth/", self.admin_data, format="json").content)["token"]

        self.user_data = {
            "username": "bob",
            "password": "111111"
        }
        self.user = User.objects.create_user(username=self.user_data["username"], password=self.user_data["password"])
        user_response = json.loads(self.client.post("/automation/api/login/", self.user_data, format="json").content)
        self.token = user_response["token"]
        self.user_id = user_response["id"]

    def test_get_project_list(self):
        response = self.client.get("/automation/api/projects/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(0, json.loads(response.content)["count"])

    def test_unable_to_create_project_if_not_authenticated(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="")
        response = self.client.post("/automation/api/projects/", data, format="json")
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_unable_to_create_project_if_authenticated_but_not_staff_or_superuser(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.token)
        response = self.client.post("/automation/api/projects/", data, format="json")
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_staff_create_project_then_get_project_list(self):
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.put(f"/automation/api/users/{self.user_id}/", {"username": self.user_data["username"], "is_staff": True}, format="json")

        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.token)
        response = self.client.post("/automation/api/projects/", data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = self.client.get("/automation/api/projects/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(1, json.loads(response.content)["count"])

    def test_superuser_create_project_then_get_project_list(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        response = self.client.post("/automation/api/projects/", data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = self.client.get("/automation/api/projects/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(1, json.loads(response.content)["count"])


class ProjectDetailTest(TestCase):

    def setUp(self):
        self.client = APIClient()
        self.admin_data = {
            "username": "admin",
            "email": "admin@test.com",
            "password": "123456"
        }
        self.admin = User.objects.create_superuser(username=self.admin_data["username"], email=self.admin_data["email"], password=self.admin_data["password"])
        self.admin_token = json.loads(self.client.post("/automation/api/api-token-auth/", self.admin_data, format="json").content)["token"]

        self.user_data = {
            "username": "bob",
            "password": "111111"
        }
        self.user = User.objects.create_user(username=self.user_data["username"], password=self.user_data["password"])
        user_response = json.loads(self.client.post("/automation/api/login/", self.user_data, format="json").content)
        self.token = user_response["token"]
        self.user_id = user_response["id"]

    def test_unable_to_update_project_if_not_authenticated(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        new_data = {
            "name": "debug2",
            "create_time": "2019-12-25T00:58:00",
            "update_time": "2019-12-26T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="")
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        response_put = self.client.put(f"/automation/api/projects/{project_id}/", new_data, format="json")
        self.assertEqual(response_put.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_unable_to_update_project_if_authenticated_but_not_staff_or_superuser(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        new_data = {
            "name": "debug2",
            "create_time": "2019-12-25T00:58:00",
            "update_time": "2019-12-26T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.token)
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        response_put = self.client.put(f"/automation/api/projects/{project_id}/", new_data, format="json")
        self.assertEqual(response_put.status_code, status.HTTP_403_FORBIDDEN)

    def test_unable_to_update_project_if_staff_but_not_superuser(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        self.client.put(f"/automation/api/users/{self.user_id}/", {"username": self.user_data["username"], "is_staff": True}, format="json")

        new_data = {
            "name": "debug2",
            "create_time": "2019-12-25T00:58:00",
            "update_time": "2019-12-26T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.token)
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        response_put = self.client.put(f"/automation/api/projects/{project_id}/", new_data, format="json")
        self.assertEqual(response_put.status_code, status.HTTP_403_FORBIDDEN)
        self.client.put(f"/automation/api/users/{self.user_id}/", {"username": self.user_data["username"], "is_staff": False}, format="json")

    def test_get_project_detail(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        self.client.credentials(HTTP_AUTHORIZATION="")
        response = self.client.get(f"/automation/api/projects/{project_id}/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(data["name"], json.loads(response.content)["name"])
        self.assertEqual(data["create_time"], json.loads(response.content)["create_time"])
        self.assertEqual(data["update_time"], json.loads(response.content)["update_time"])

    def test_update_project_detail_when_superuser(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        new_data = {
            "name": "debug2",
            "create_time": "2019-12-25T00:58:00",
            "update_time": "2019-12-26T00:59:00"
        }
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        response_put = self.client.put(f"/automation/api/projects/{project_id}/", new_data, format="json")
        self.assertEqual(response_put.status_code, status.HTTP_200_OK)
        response = self.client.get(f"/automation/api/projects/{project_id}/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(new_data["name"], json.loads(response.content)["name"])
        self.assertEqual(new_data["create_time"], json.loads(response.content)["create_time"])
        self.assertEqual(new_data["update_time"], json.loads(response.content)["update_time"])

    def test_update_project_detail_when_project_owner(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        self.client.put(f"/automation/api/projects/{project_id}/", {"name": "debug", "owner": [self.user_id]}, format="json")

        new_data = {
            "name": "debug2",
            "create_time": "2019-12-25T00:58:00",
            "update_time": "2019-12-26T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.token)
        response_put = self.client.put(f"/automation/api/projects/{project_id}/", new_data, format="json")
        self.assertEqual(response_put.status_code, status.HTTP_200_OK)
        response = self.client.get(f"/automation/api/projects/{project_id}/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(new_data["name"], json.loads(response.content)["name"])
        self.assertEqual(new_data["create_time"], json.loads(response.content)["create_time"])
        self.assertEqual(new_data["update_time"], json.loads(response.content)["update_time"])

    def test_update_project_detail_partial(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        new_data = {
            "name": "debug_update",
        }
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        response_patch = self.client.patch(f"/automation/api/projects/{project_id}/", new_data, format="json")
        self.assertEqual(response_patch.status_code, status.HTTP_200_OK)
        response = self.client.get(f"/automation/api/projects/{project_id}/", format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(new_data["name"], json.loads(response.content)["name"])
        self.assertEqual(data["create_time"], json.loads(response.content)["create_time"])
        self.assertEqual(data["update_time"], json.loads(response.content)["update_time"])

    def test_unable_delete_project(self):
        data = {
            "name": "debug",
            "create_time": "2019-12-22T00:58:00",
            "update_time": "2019-12-23T00:59:00"
        }
        self.client.credentials(HTTP_AUTHORIZATION="Token " + self.admin_token)
        self.client.post("/automation/api/projects/", data)
        project_id = json.loads(self.client.get("/automation/api/projects/", format="json").content)["results"][0]["id"]
        response_delete = self.client.delete(f"/automation/api/projects/{project_id}/")
        self.assertEqual(response_delete.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
        self.assertEqual({'detail': '方法 “DELETE” 不被允许。'}, json.loads(response_delete.content))
