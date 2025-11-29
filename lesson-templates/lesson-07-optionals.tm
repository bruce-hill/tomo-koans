# Optional Types

func main()

    # Any type can be optional, which means it will either be
    # `none` or have a value. You can declare an optional variable
    # and initialize it to `none` like this:
    y : Int? = none

    assert y == ???

    # Optional variables can be either `none` or a value of that type:

    y = 123
    assert y == 123

    # Some functions return optional values.
    # Int.parse(text:Text -> Int?) is a function that returns
    # an integer value found in the text, or `none` if no integer
    # is found.
    assert Int.parse("123") == ???
    assert Int.parse("blah") == ???

    # You can check if a value exists with `if`:
    n := Int.parse("123")
    if n
        # Inside this condition, `n` is known to be non-none
        n = add(n, 1)
        assert n == ???

    # Optionals are useful for handling missing data:
    name : Text? = none
    greeting := if name
        "Hello $name"
    else
        "Hello stranger"

    assert greeting == ???

    # Optional values can be converted to non-optional using `or`
    assert Int.parse("blah") or 0 == ???

    # They can also be converted using the `!` operator, which
    # will give an error if a non-none value is encountered:
    assert add(Int.parse("123")!, 1) == ???

    # If you index into a list, the value is optional because
    # you might have used an index that isn't in the list:
    list := [10, 20, 30]
    assert list[1] == 10
    assert list[999] == none

    # So, it's common to see `list[i]!` to force the value to
    # be non-optional or error if you made a mistake:
    assert list[3]! == ???

func add(x:Int, y:Int -> Int)
    return x + y
