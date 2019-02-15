import json
import os


def test_glove(client):
    response = client.post("/glove",
                           data={"word": "hello"},
                           content_type="application/x-www-form-urlencoded",
                           headers={"Authorization": os.environ["ACCESS_TOKEN"]})
    assert response.status_code == 200
    data = json.loads(response.data)
    assert "word" in data
    assert "encoding" in data
