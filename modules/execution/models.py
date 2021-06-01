from django.db import models
from django.utils import timezone


class Browser(models.Model):

    name = models.CharField(max_length=100)
    alias = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return f"{self.name} - {self.version}"


class Device(models.Model):

    name = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.name


class Driver(models.Model):

    name = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)
    comment = models.CharField(max_length=2000)

    def __str__(self):
        return f"{self.name} - {self.version}"


class MobileOS(models.Model):

    name = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return f"{self.name} - {self.version}"

    class Meta:
        db_table = "execution_mobile_os"


class PlatformOS(models.Model):

    name = models.CharField(max_length=100)
    version = models.CharField(max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return f"{self.name} - {self.version}"

    class Meta:
        db_table = "execution_platform_os"


class TestEnvironment(models.Model):

    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

    class Meta:
        db_table = "execution_environment"
