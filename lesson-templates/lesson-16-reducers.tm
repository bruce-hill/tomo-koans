# Reductions

func main()

    # Reductions fold collections into a single value:
    assert (+: [1, 2, 3])! == ???
    assert (*: [2, 3, 4])! == ???

    # If an empty argument is given, a `none` value is returned
    empty : [Int] = []
    assert (+: empty) == none

    # Use `or` to provide a fallback:
    assert (+: empty) or 100 == ???

    # `_min_` and `_max_` work as reducers:
    assert (_max_: [10, 30, 20])! == ???
    assert (_min_.length: ["x", "abcd", "yz"])! == "???"

    # Comprehensions inside reductions:
    assert (+: i * 2 for i in [1, 2, 3])! == ???

    assert (+: i for i in 10 if i.is_prime())! == ???
