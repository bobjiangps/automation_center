from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from modules.execution.models import *


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
    # author = models.ForeignKey(User)
    maintainer = models.CharField(max_length=100, blank=True)
    # maintainer = models.ForeignKey(User)
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

    SUITE_TYPES = (
        ("Debug", "Debug"),
        ("BVT", "BVT"),
        ("Regression", "Regression")
    )

    name = models.CharField(max_length=100)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    script = models.ManyToManyField(Script)
    suite_type = models.CharField(choices=SUITE_TYPES, default=SUITE_TYPES[0][0], max_length=100)
    # cannot use limit_choise_to for referring to model forienkey field like limit_choices_to={'project': project}
    # https://stackoverflow.com/questions/31578559/django-foreignkey-limit-choices-to-a-different-foreignkey-id
    # script = models.ManyToManyField(Script, limit_choices_to={'project': 2})
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.name

    class Meta:
        db_table = "projects_test_suite"
        unique_together = ("name", "project")


class TestRound(models.Model):

    STATUS_TYPES = (
        ("Waiting", "Waiting"),
        ("Running", "Running"),
        ("Completed", "Completed")
    )
    RESULT_TYPES = (
        ("NotRun", "NotRun"),
        ("Pass", "Pass"),
        ("Fail", "Fail"),
        ("Warning", "Warning")
    )

    name = models.CharField(max_length=100)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    status_type = models.CharField(choices=STATUS_TYPES, default=STATUS_TYPES[0][0], max_length=100)
    result_type = models.CharField(choices=RESULT_TYPES, default=RESULT_TYPES[0][0], max_length=100)
    pass_count = models.IntegerField(default=0)
    fail_count = models.IntegerField(default=0)
    warning_count = models.IntegerField(default=0)
    not_run_count = models.IntegerField(default=0)
    test_suite = models.ForeignKey(TestSuite, on_delete=models.SET_NULL, null=True)
    test_environment = models.ForeignKey(TestEnvironment, on_delete=models.SET_NULL, null=True)
    browser = models.ForeignKey(Browser, on_delete=models.SET_NULL, blank=True, null=True)
    device = models.ForeignKey(Device, on_delete=models.SET_NULL, blank=True, null=True)
    mobile_os = models.ForeignKey(MobileOS, on_delete=models.SET_NULL, blank=True, null=True)
    platform_os = models.ForeignKey(PlatformOS, on_delete=models.SET_NULL, blank=True, null=True)
    creator = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    start_time = models.DateTimeField(default=timezone.now)
    end_time = models.DateTimeField(blank=True, null=True)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)
    extra_info = models.CharField(max_length=1000)

    class Meta:
        db_table = "projects_test_round"
