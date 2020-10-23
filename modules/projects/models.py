from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User


class Project(models.Model):

    PROJECT_TYPES = (
        ("internal", "internal"),
        ("public", "public")
    )
    name = models.CharField(max_length=100, unique=True)
    project_type = models.CharField(choices=PROJECT_TYPES, default=PROJECT_TYPES[0][0], max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)
    # owner = models.ManyToManyField(User, blank=True)

    def __str__(self):
        return self.name


class Script(models.Model):

    name = models.CharField(max_length=100)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    version = models.CharField(max_length=100, blank=True)
    status = models.CharField(max_length=100, blank=True)
    author = models.CharField(max_length=100, blank=True)
    maintainer = models.CharField(max_length=100, blank=True)
    file_created = models.DateField(blank=True, null=True)
    file_updated = models.DateField(blank=True, null=True)
    tag = models.CharField(max_length=100, blank=True)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)


class ScriptFunction(models.Model):

    name = models.CharField(max_length=100)
    script = models.ForeignKey(Script, on_delete=models.CASCADE)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = "projects_script_function"


class AutomatedCase(models.Model):

    name = models.CharField(max_length=100)
    script_function = models.ForeignKey(ScriptFunction, on_delete=models.CASCADE)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = "projects_automated_case"


class TestSuite(models.Model):

    name = models.CharField(max_length=100)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    script = models.ManyToManyField(Script, blank=True)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = "projects_test_suite"
        unique_together = ("name", "project")
