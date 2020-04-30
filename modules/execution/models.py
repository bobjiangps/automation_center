from django.db import models
from django.utils import timezone


class Browser(models.Model):

    name = models.CharField(max_length=100)
    alias = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)


class Device(models.Model):

    name = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)


class Driver(models.Model):

    name = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)
    comment = models.CharField(max_length=2000)


class MobileOS(models.Model):

    name = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = "execution_mobile_os"


class PlatformOS(models.Model):

    name = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = "execution_platform_os"


class TestEnvironment(models.Model):

    name = models.CharField(max_length=100)

    class Meta:
        db_table = "execution_environment"
