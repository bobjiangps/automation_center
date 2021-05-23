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
    path(r'<int:project_id>/test-script-authors/', views.TestScriptAuthors.as_view(), name='script_authors'),
    path(r'<int:project_id>/test-scripts/<int:pk>/', views.ScriptDetail.as_view(), name='script_detail'),
    path(r'<int:project_id>/test-scripts/<int:script_id>/automation-case', views.AutomationCaseList.as_view(), name='automation_case_list'),
    path(r'<int:project_id>/test-scripts/<int:script_id>/automation-case/<int:pk>/', views.AutomationCaseDetail.as_view(), name='automation_case_detail'),
    path(r'<int:project_id>/test-suites/', views.TestSuiteList.as_view(), name='test_suite_list'),
    path(r'<int:project_id>/test-suites/<int:pk>/', views.TestSuiteDetail.as_view(), name='test_suite_detail'),
    path(r'test-suite-types/', views.TestSuiteTypes.as_view(), name='test_suite_types'),
]
