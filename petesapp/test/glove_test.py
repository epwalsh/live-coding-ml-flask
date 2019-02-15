from petesapp.glove import encode_word


def test_encode_word():
    encoding = encode_word("hello")
    assert isinstance(encoding, list)
    assert len(encoding) == 50
    assert isinstance(encoding[0], float)
