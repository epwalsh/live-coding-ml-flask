import logging
import json

from flask import Flask, Response, request

from petesapp.glove import encode_word
from petesapp.webserver.auth import authenticate_token


logging.basicConfig(level=logging.INFO)


application = Flask(__name__)  # pylint: disable=invalid-name


@application.route("/health", methods=["GET"], strict_slashes=False)
def health_check():
    return Response("So healthy RN! Thanks for checking :)", status=200)


@application.route("/glove", methods=["POST"], strict_slashes=False)
@authenticate_token
def glove():
    data = request.form.to_dict()
    if "word" not in data:
        return Response("Missing 'word' parameter", status=400)
    word = data["word"]
    encoding = encode_word(word)
    return Response(json.dumps({"word": word, "encoding": encoding}), mimetype="application/json")


if __name__ == "__main__":
    application.run(debug=True)
