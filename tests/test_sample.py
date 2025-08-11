from src.main import add

def test_add_positive():
    assert add(2, 3) == 5

def test_add_negative_and_positive():
    assert add(-1, 1) == 0
