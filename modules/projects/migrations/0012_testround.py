# Generated by Django 2.2.9 on 2021-05-27 21:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('execution', '0003_mobileos_platformos_testenvironment'),
        ('projects', '0011_testsuite_suite_type'),
    ]

    operations = [
        migrations.CreateModel(
            name='TestRound',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('status_type', models.CharField(choices=[('Waiting', 'Waiting'), ('Running', 'Running'), ('Completed', 'Completed')], default='Waiting', max_length=100)),
                ('result_type', models.CharField(choices=[('NotRun', 'NotRun'), ('Pass', 'Pass'), ('Fail', 'Fail'), ('Warning', 'Warning')], default='NotRun', max_length=100)),
                ('pass_count', models.IntegerField(default=0)),
                ('fail_count', models.IntegerField(default=0)),
                ('warning_count', models.IntegerField(default=0)),
                ('not_run_count', models.IntegerField(default=0)),
                ('start_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('end_time', models.DateTimeField(blank=True, null=True)),
                ('create_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('update_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('extra_info', models.CharField(max_length=1000)),
                ('browser', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='execution.Browser')),
                ('creator', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
                ('device', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='execution.Device')),
                ('mobile_os', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='execution.MobileOS')),
                ('platform_os', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='execution.PlatformOS')),
                ('project', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projects.Project')),
                ('test_environment', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='execution.TestEnvironment')),
                ('test_suite', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='projects.TestSuite')),
            ],
            options={
                'db_table': 'projects_test_round',
            },
        ),
    ]