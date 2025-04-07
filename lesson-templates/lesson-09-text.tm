# Text

func main()

    # Text values are sequences of letters.
    greeting := "Hello"

    >> greeting.length
    = ???

    # Text supports interpolation with `$`:
    name := "Alice"
    message := "Hello $name, your number is $(1 + 2)!"

    >> message
    = ???

    # Multi-line text uses indented quotes:
    multiline := "
        line one
        line two
        line three
    "

    # Method calls use `.`
    >> multiline.lines()
    = [???]

    # Common text methods:
    >> "hello".upper()
    = ???

    >> "hello world".split(" ")
    = [???]
