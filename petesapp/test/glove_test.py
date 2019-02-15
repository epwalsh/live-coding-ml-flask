from petesapp.glove import encode_word


def test_encode_word():
    vector = encode_word("hello")
    assert isinstance(vector, list)
    assert len(vector) == 50
    assert isinstance(vector[0], float), type(vector[0])
