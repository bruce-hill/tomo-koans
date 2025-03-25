# Optional Types

func main():

    # Any type `T` can be made optional with the syntax `T?`,
    # meaning it can hold a value or be `none`.

    x := 42?
    >> x
    = 42

    # You can assign a `none` value to `x` because it has type `Int?`
    x = none

    # To declare a `none` variable, specify its type:
    y := none:Int

    >> y
    = ???

    # Some functions return optional values.
    # Int.parse(text:Text -> Int?) is a function that returns
    # an integer value found in the text, or `none` if no integer
    # is found.
    >> Int.parse("123")
    = ???
    >> Int.parse("blah")
    = ???

    # You can check if a value exists with `if`:
    n := Int.parse("123")
    if n:
        # Inside this condition, `n` is known to be non-none
        n = add(n, 1)
        >> n
        = ???

    # Optionals are useful for handling missing data:
    name := none:Text
    greeting := if name:
        "Hello, $name!"
    else:
        "Hello, stranger!"

    >> greeting
    = ???

    # Optional values can be converted to non-optional using `or`
    >> Int.parse("blah") or 0
    = ???

    # They can also be converted using the `!` operator, which
    # will give an error if a non-none value is encountered:
    >> add(Int.parse("123")!, 1)
    = ???

func add(x:Int, y:Int -> Int):
    return x + y
