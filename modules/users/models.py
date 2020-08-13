from django.db import models
from django.contrib.auth.models import Group, User
from modules.projects.models import Project


class Role(models.Model):
    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        unique_together = ("group", "project", "user")
