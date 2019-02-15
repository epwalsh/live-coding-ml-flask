from typing import List

import torchtext.vocab as vocab


glove_model = vocab.GloVe(name="6B", dim=50)  # pylint: disable=invalid-name


def encode_word(word: str) -> List[float]:
    return [float(x) for x in glove_model.vectors[glove_model.stoi[word]]]
