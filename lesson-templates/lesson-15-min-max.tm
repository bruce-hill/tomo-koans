# Min and Max

struct Point(x:Int, y:Int)

func main()

    # `_min_` and `_max_` return the smaller or larger of two values:
    >> 7 _min_ 3
    = ???
    >> "apple" _max_ "banana"
    = "???"

    # You can use an indexed key for choosing a maximum:
    >> Point(1, 2) _max_.y Point(999, 0)
    = Point(x=???, y=???)

    >> [1, 2, 3] _min_.length [99, 100]
    = [???]

    # You can also use a method for choosing a maximum:
    >> 5 _max_.abs() -999
    = ???
