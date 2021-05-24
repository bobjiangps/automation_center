from automation_center.settings import REST_FRAMEWORK as rf
from rest_framework.pagination import PageNumberPagination


class LargeResultsSetPagination(PageNumberPagination):
    page_size = rf["PAGE_SIZE"]
    page_size_query_param = 'page_size'
    max_page_size = 100000
