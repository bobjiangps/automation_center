import json
import time
import datetime
from django.utils import timezone
from rest_framework import status
from rest_framework.test import APITestCase
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token


class AuthenticationTest(APITestCase):

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

    def test_get_only_token_when_login(self):
        user_response = self.client.post("/automation/api/api-token-auth/", self.user_data, format="json")
        response_keys = json.loads(user_response.content).keys()
        self.assertEqual(1, len(response_keys))
        self.assertTrue("token" in response_keys)
        self.assertEqual(user_response.status_code, status.HTTP_200_OK)

    def test_get_user_info_when_login(self):
        user_response = self.client.post("/automation/api/login/", self.user_data, format="json")
        response_keys = json.loads(user_response.content).keys()
        self.assertEqual(4, len(response_keys))
        self.assertTrue("id" in response_keys)
        self.assertTrue("username" in response_keys)
        self.assertTrue("mail" in response_keys)
        self.assertTrue("token" in response_keys)
        self.assertEqual(user_response.status_code, status.HTTP_200_OK)

    def test_token_should_be_deleted_after_logout(self):
        user_response = json.loads(self.client.post("/automation/api/login/", self.user_data, format="json").content)
        self.assertEqual(2, Token.objects.count())
        token = user_response["token"]
        self.client.credentials(HTTP_AUTHORIZATION="Token " + token)
        logout_response = self.client.post("/automation/api/logout/")
        self.assertEqual(logout_response.status_code, status.HTTP_200_OK)
        self.assertEqual(1, Token.objects.count())
        self.client.credentials(HTTP_AUTHORIZATION="")

    def test_login_failed(self):
        not_exist_user_data = {
            "username": "not_exist@test.com",
            "password": "111111"
        }
        user_response = self.client.post("/automation/api/login/", not_exist_user_data, format="json")
        self.assertEqual(user_response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual({'non_field_errors': ['无法使用提供的认证信息登录。']}, json.loads(user_response.content))

    def test_token_expiration_rule(self):
        self.client.post("/automation/api/login/", self.user_data, format="json")
        user_token_before = Token.objects.filter(user_id=self.user.id)[0]
        self.client.post("/automation/api/login/", self.user_data, format="json")
        user_token_after = Token.objects.filter(user_id=self.user.id)[0]
        self.assertTrue(user_token_before.key, user_token_after.key)
        now = datetime.datetime.now()
        user_token_after.created = now - datetime.timedelta(hours=24)
        user_token_after.save()
        time.sleep(1)
        self.client.post("/automation/api/login/", self.user_data, format="json")
        user_token_after_updated = Token.objects.filter(user_id=self.user.id)[0]
        self.assertTrue(user_token_after.key != user_token_after_updated.key)
