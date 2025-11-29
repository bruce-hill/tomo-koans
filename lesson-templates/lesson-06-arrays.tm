# Arrays

func main()

    # Arrays are ordered collections of values.
    # You can define an array using `[...]`:

    nums := [10, 20, 30]

    # Arrays are 1-indexed.
    assert nums[2] == ???

    # Arrays can be empty but must have a type:
    empty : [Int] = []

    assert empty == []

    # You can loop over an array with `for value in array`:
    sum := 0
    for num in nums
        sum += num

    assert sum == ???

    # Array comprehensions let you transform arrays concisely:
    squares := [n*n for n in nums]

    assert squares == [???, ???, ???]

    # You can also get the index with `for index, value in array`:
    for i, num in nums
        assert squares[i] == num * num
