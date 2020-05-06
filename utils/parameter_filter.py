from rest_framework.filters import BaseFilterBackend
from rest_framework.compat import coreapi
import yaml


class ParameterFilter(BaseFilterBackend):

    def get_schema_fields(self, view):
        default = {
            "name": "no name",
            "location": "query",
            "required": False,
            "type": "string",
            "description": "no description"
        }
        params = yaml.load(view.__doc__)["parameters"]
        fields = []
        for p in params:
            new_p = {}
            for k in default.keys():
                if k in p.keys():
                    new_p[k] = p[k]
                else:
                    new_p[k] = default[k]
            fields.append(coreapi.Field(
                name=new_p["name"],
                location=new_p["location"],
                required=new_p["required"],
                type=new_p["type"],
                description=new_p["description"]
            ))
        return fields

    def filter_queryset(self, request, queryset, view):
        return queryset
