# Reductions

func main():

    # Reductions fold collections into a single value:
    >> (+: [1, 2, 3])!
    = ???
    >> (*: [2, 3, 4])!
    = ???

    # If an empty argument is given, a `none` value is returned
    empty := [:Int]
    >> (+: empty)
    = none:Int

    # Use `or` to provide a fallback:
    >> (+: empty) or 100
    = ???

    # `_min_` and `_max_` work as reducers:
    >> (_max_: [10, 30, 20])!
    = ???
    >> (_min_.length: ["x", "abcd", "yz"])!
    = "???"

    # Comprehensions inside reductions:
    >> (+: i * 2 for i in [1, 2, 3])!
    = ???

    >> (+: i for i in 10 if i:is_prime())!
    = ???
