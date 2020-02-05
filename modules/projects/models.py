from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User


class Project(models.Model):

    PROJECT_TYPES = (
        ("internal", "internal"),
        ("public", "public")
    )
    name = models.CharField(max_length=100)
    project_type = models.CharField(choices=PROJECT_TYPES, default=PROJECT_TYPES[0][0], max_length=100)
    create_time = models.DateTimeField(default=timezone.now)
    update_time = models.DateTimeField(default=timezone.now)
    owner = models.ManyToManyField(User, blank=True)

    def __str__(self):
        return self.name
