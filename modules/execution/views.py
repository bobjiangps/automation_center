from .models import Browser, Device, Driver, MobileOS, PlatformOS, TestEnvironment
from rest_framework.views import APIView
from rest_framework.response import Response


class ExecutionInfo(APIView):

    queryset = TestEnvironment.objects.none()

    def get(self, request):
        """
        Return the data of execution models.
        """
        browsers = Browser.objects.all().order_by("-id")
        devices = Device.objects.all().order_by("-id")
        drivers = Driver.objects.all().order_by("-id")
        mobile_os = MobileOS.objects.all().order_by("-id")
        platform_os = PlatformOS.objects.all().order_by("-id")
        env = TestEnvironment.objects.all().order_by("-id")
        return Response({
            "browsers": [{"id": b.id, "value": b.__str__()} for b in browsers],
            "devices": [{"id": d.id, "value": d.__str__()} for d in devices],
            "drivers": [{"id": d.id, "value": d.__str__()} for d in drivers],
            "mobile_os": [{"id": m.id, "value": m.__str__()} for m in mobile_os],
            "platform_os": [{"id": p.id, "value": p.__str__()} for p in platform_os],
            "env": [{"id": e.id, "value": e.__str__()} for e in env],
        })
