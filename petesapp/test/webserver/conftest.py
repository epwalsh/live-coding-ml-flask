import pytest

from petesapp.webserver.app import application


@pytest.fixture
def client():
    application.config["TESTING"] = True
    yield application.test_client()
