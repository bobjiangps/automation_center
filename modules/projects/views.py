from .models import Project, Script, ScriptFunction, AutomatedCase
from .serializers import ProjectSerializer
from rest_framework import viewsets


# class ProjectViewSet(viewsets.ModelViewSet):
#     """
#     this is the common usage with all request method, in this way, no need to add url.py in app
#     """
#     queryset = Project.objects.all().order_by("id")
#     serializer_class = ProjectSerializer
#
#     # # 如果想禁用某一个方法，可以类似如下，但不如用generics.RetrieveUpdateAPIView
#     # def destroy(self, request, *args, **kwargs):
#     #     return Response({"message": "delete action is not allowed", "code": "200"}, status=status.HTTP_200_OK)


## the following two methods with apiview are used to customized http method for objects, with more code
# from django.http import Http404
# from rest_framework.views import APIView
# from rest_framework.response import Response
# from rest_framework import status
#
#
# class ProjectList(APIView):
#     # 定义 GET 请求的方法，内部实现相同 @api_view
#     def get(self, request):
#         projects = Project.objects.all().order_by("id")
#         serializer = ProjectSerializer(projects, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     # 定义 POST 请求的方法
#     def post(self, request):
#         serializer = ProjectSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#
# class ProjectDetail(APIView):
#
#     def get_object(self, pk):
#         try:
#             return Project.objects.get(pk=pk)
#         except Project.DoesNotExist:
#             raise Http404
#
#     def get(self, request, pk):
#         project = self.get_object(pk)
#         serializer = ProjectSerializer(project)
#         return Response(serializer.data)
#
#     def put(self, request, pk):
#         project = self.get_object(pk)
#         serializer = ProjectSerializer(project, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     ## to permit delete action or not
#     # def delete(self, request, pk):
#     #     project = self.get_object(pk)
#     #     project.delete()
#     #     return Response(status=status.HTTP_204_NO_CONTENT)



# # the following two methods with apiview are used to customized http method for objects, with less code
# from rest_framework import mixins
# from rest_framework import generics
#
#
# class ProjectList(mixins.ListModelMixin,
#                   mixins.CreateModelMixin,
#                   mixins.UpdateModelMixin,
#                   generics.GenericAPIView):
#     # 指定列表
#     queryset = Project.objects.all()
#     # 指定序列化类
#     serializer_class = ProjectSerializer
#
#     def get(self, request, *args, **kwargs):
#         # list 方法继承 ListModelMixin 而来
#         return self.list(self, request, *args, **kwargs)
#
#     def post(self, request, *args, **kwargs):
#         # create 方法继承 CreateModelMixin 而来
#         return self.create(self, request, *args, **kwargs)
#
#
# # detail 视图通过 mixins 和 generics 改造
# class ProjectDetail(mixins.RetrieveModelMixin,
#                     mixins.UpdateModelMixin,
#                     mixins.DestroyModelMixin,
#                     generics.GenericAPIView):
#     queryset = Project.objects.all()
#     serializer_class = ProjectSerializer
#
#     def get(self, request, *args, **kwargs):
#         return self.retrieve(self, request, *args, **kwargs)
#
#     def put(self, request, *args, **kwargs):
#         return self.update(self, request, *args, **kwargs)
#
#     def delete(self, request, *args, **kwargs):
#         return self.destroy(self, request, *args, **kwargs)



# the following two methods with apiview are used to customized http method for objects, with least code
from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import filters
from utils.permission import IsSpecifiedProjectOrReadOnly, IsSuperUserOrReadOnly


class ProjectList(generics.ListCreateAPIView):
    """
        get:
            Return all projects.

        post:
            Create a new project.
    """
    permission_classes = [IsSuperUserOrReadOnly]
    queryset = Project.objects.all().order_by("id")
    serializer_class = ProjectSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["name", "=project_type"]


class ProjectDetail(generics.RetrieveUpdateAPIView):
    """
        get:
            Return a project instance.

        put:
            Update a project.

        patch:
            Update one or more fields on an existing project.

    """
    permission_classes = [IsSpecifiedProjectOrReadOnly]
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer


class ProjectAmount(APIView):

    queryset = Project.objects.none()

    def get(self, request):
        """
        Return amount of current projects.
        """
        count = {"count": Project.objects.count()}
        return Response(count)


class ProjectNames(APIView):

    queryset = Project.objects.none()

    def get(self, request):
        """
        Return names of current projects.
        """
        names = {"names": []}
        for p in Project.objects.all():
            names["names"].append(p.name)
        return Response(names)


class AutomatedCaseAmount(APIView):

    queryset = AutomatedCase.objects.none()

    def get(self, request):
        """
        Return amount of automated cases of all projects.
        """
        count = {"count": AutomatedCase.objects.count()}
        return Response(count)


# class ExampleParameterInUrl(APIView):
#
#     permission_classes = [IsSpecifiedProjectOrReadOnly]
#     queryset = Project.objects.none()
#
#     def get(self, request, project_id, user_id):
#         """
#         Example to pass parameters from url
#         """
#         print(request.parser_context["kwargs"])
#         count = {"count": Project.objects.count(), "project_id": project_id, "user_id": user_id}
#         return Response(count)
#
#
# class ExampleParameterInRequest(APIView):
#
#     permission_classes = [IsSpecifiedProjectOrReadOnly]
#     queryset = Project.objects.none()
#
#     def get(self, request):
#         """
#         Example to pass parameters in request data
#         """
#         print(request.data)
#         count = {"count": Project.objects.count(), "project_id": request.data["project_id"], "user_id": request.data["user_id"]}
#         return Response(count)
