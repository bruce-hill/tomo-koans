# Tables

func main()

    # Tables store key-value pairs.
    # You can define a table using `{key: value, ...}`.

    scores := {"Alice": 100, "Bob": 200}
    assert scores == {"Alice": 100, "Bob": 200}

    assert scores["Alice"] == ???

    # Accessing a missing key gives `none`
    assert scores["Zoltan"] == ???

    # Tables can be empty but must have key and value types:
    empty : {Text:Int} = {}
    assert empty == {}

    # You can loop over tables:
    total := 0
    for name, score in scores
        total += score

    assert total == ???

    # Table keys and values can be accessed as an array:
    assert scores.keys == [???]

    assert scores.values == [???]

    # Table comprehensions let you create tables concisely:
    doubled := {k: v * 2 for k, v in scores}
    assert doubled == {???}
