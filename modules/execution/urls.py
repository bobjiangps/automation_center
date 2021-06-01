from django.urls import path
from . import views

urlpatterns = [
    path('', views.ExecutionInfo.as_view(), name='execution_info'),
]
