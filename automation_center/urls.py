"""automation_center URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path
from rest_framework import routers
from rest_framework.schemas import get_schema_view
from rest_framework_swagger.renderers import SwaggerUIRenderer, OpenAPIRenderer
# from rest_framework.authtoken.views import obtain_auth_token
from modules.users import views as u_views
from modules.users import views_auth_token as uat_views


router = routers.DefaultRouter()
router.register(r'users', u_views.UserViewSet)
router.register(r'groups', u_views.GroupViewSet)
router.register(r'roles', u_views.RoleViewSet)
router.register(r'permissions', u_views.PermissionViewSet)

schema_view = get_schema_view(title='API DOC', renderer_classes=[SwaggerUIRenderer, OpenAPIRenderer])

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('automation/api/', include(router.urls)),
    path('automation/api/projects/', include('modules.projects.urls')),
    path('automation/admin/', admin.site.urls),
    path('automation/api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    # path('automation/api/api-token-auth/', obtain_auth_token, name='api_token_auth'),
    path('automation/api/api-token-auth/', uat_views.ObtainExpiringAuthToken.as_view(), name='api_token_auth'),
    path('automation/api/login/', uat_views.ObtainExpiringAuthToken.as_view(), name='login'),
    # path('automation/api/logout/', uat_views.ObtainExpiringAuthToken.as_view(), name='logout'),
    path('automation/api/logout/', uat_views.RevokeAuthToken.as_view(), name='logout'),
    path('automation/api/docs/', schema_view, name='docs'),
    path('automation/api/users/me', u_views.CurrentUser.as_view(), name='current_user')
]
