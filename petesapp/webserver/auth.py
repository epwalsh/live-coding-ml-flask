from functools import wraps
import os

from flask import Response, request


def authenticate_token(endpoint):
    @wraps(endpoint)
    def wrapper():
        headers = request.headers
        if headers.get("Authorization") != os.environ["ACCESS_TOKEN"]:
            return Response(status=401)
        return endpoint()
    return wrapper
