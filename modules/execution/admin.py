from .models import Browser, Device, Driver, MobileOS, PlatformOS, TestEnvironment
from django.contrib import admin


admin.site.register(Browser)
admin.site.register(Device)
admin.site.register(Driver)
admin.site.register(MobileOS)
admin.site.register(PlatformOS)
admin.site.register(TestEnvironment)
