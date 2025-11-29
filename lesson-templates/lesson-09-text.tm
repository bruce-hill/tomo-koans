# Text

func main()

    # Text values are sequences of letters.
    greeting := "Hello"

    assert greeting.length == ???

    # Text supports interpolation with `$`:
    name := "Alice"
    message := "Hello $name, your number is $(1 + 2)"

    assert message == ???

    # Multi-line text uses indented quotes:
    multiline := "
        line one
        line two
        line three
    "

    # Method calls use `.`
    assert multiline.lines() == [???]

    # Common text methods:
    assert "hello".upper() == ???

    assert "hello world".split(" ") == [???]
