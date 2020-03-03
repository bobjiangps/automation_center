from django.urls import path
from . import views

urlpatterns = [
    path('', views.ProjectList.as_view(), name='project_list'),
    path(r'<int:pk>/', views.ProjectDetail.as_view(), name='project_detail'),
    path(r'amount/', views.ProjectAmount.as_view(), name='project_amount'),
    # path(r'in_url/project/<int:project_id>/user/<int:user_id>/', views.ExampleParameterInUrl.as_view(), name='example_parameter_in_url'),
    # path(r'in_request/', views.ExampleParameterInRequest.as_view(), name='example_parameter_in_request'),
]
