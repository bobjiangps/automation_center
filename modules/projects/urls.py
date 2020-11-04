from django.urls import path
from . import views

urlpatterns = [
    path('', views.ProjectList.as_view(), name='project_list'),
    path(r'<int:pk>/', views.ProjectDetail.as_view(), name='project_detail'),
    path(r'amount/', views.ProjectAmount.as_view(), name='project_amount'),
    path(r'names/', views.ProjectNames.as_view(), name='project_names'),
    path(r'automated_case_amount/', views.AutomatedCaseAmount.as_view(), name='project_automated_case_amount'),
    path(r'mock_automation_coverage/', views.MockAutomationCoverageData.as_view(), name='mock_project_automation_coverage'),
    # path(r'in_url/project/<int:project_id>/user/<int:user_id>/', views.ExampleParameterInUrl.as_view(), name='example_parameter_in_url'),
    # path(r'in_request/', views.ExampleParameterInRequest.as_view(), name='example_parameter_in_request'),
    path(r'<int:project_id>/test-scripts/', views.ScriptList.as_view(), name='script_list'),
    path(r'<int:project_id>/test-scripts/<int:pk>/', views.ScriptDetail.as_view(), name='script_detail'),
]
