# Heap Allocation with `@`

func main():

    # By default, values in Tomo are immutable.
    # To allow mutation, you need to allocate memory using `@`

    nums := @[1, 2, 3]
    nums[1] = 99

    >> nums
    = @[???, 2, 3]

    nums:insert(40)
    >> nums
    = @[???, 2, 3, ???]

    # Allocated memory is not equal to other allocated memory:
    a := @[10, 20, 30]
    b := @[10, 20, 30]
    >> a == b
    = ???

    # The `[]` operator can be used to access the value stored
    # at a memory location:
    >> a[] == b[]
    = ???

    # Tables also require `@` to allow modifications:
    scores := @{"Alice"=100, "Bob"=200}

    scores["Charlie"] = 300

    >> scores["Charlie"]
    = ???

    # Without `@`, attempting to mutate will cause an error:
    frozen := {"key"="value"}
    frozen["key"] = "new value" # <- This will break, comment it out

    >> frozen["key"]
    = "value"?
