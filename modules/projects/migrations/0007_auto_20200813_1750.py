# Generated by Django 2.2.9 on 2020-08-13 17:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0006_testsuite'),
    ]

    operations = [
        migrations.AlterField(
            model_name='project',
            name='name',
            field=models.CharField(max_length=100, unique=True),
        ),
        migrations.AlterUniqueTogether(
            name='testsuite',
            unique_together={('name', 'project')},
        ),
    ]
