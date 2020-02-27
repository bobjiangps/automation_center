from django.urls import path
from . import views

urlpatterns = [
    path('', views.ProjectList.as_view(), name='project_list'),
    path(r'<int:pk>/', views.ProjectDetail.as_view(), name='project_detail'),
    path(r'project_amount/', views.ProjectAmount.as_view(), name='project_count'),
]
