# Heap Allocation with `@`

func main()

    # By default, values in Tomo are immutable.
    # To allow mutation, you need to allocate memory using `@`

    nums := @[10, 20, 30]
    nums[1] = 99

    assert nums[1] == ???

    nums.insert(40)
    assert nums[4] == ???

    # Allocated memory is not equal to other allocated memory:
    a := @[10, 20, 30]
    b := @[10, 20, 30]
    pointers_are_equal := (a == b)
    assert pointers_are_equal == ???

    # The `[]` operator can be used to access the value stored
    # at a memory location:
    contents_are_equal := (a[] == b[])
    assert contents_are_equal == ???

    # Tables also require `@` to allow modifications:
    scores := @{"Alice": 100, "Bob": 200}

    scores["Charlie"] = 300

    assert scores["Charlie"] == ???

    # Without `@`, attempting to mutate will cause an error:
    frozen := {"key": "value"}
    frozen["key"] = "new value" # <- This will break, comment it out

    assert frozen["key"] == "value"
