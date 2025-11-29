# Min and Max

struct Point(x:Int, y:Int)

func main()

    # `_min_` and `_max_` return the smaller or larger of two values:
    smallest_int := 7 _min_ 3
    assert smallest_int == ???

    most_fruit := "apple" _max_ "banana"
    assert most_fruit == ???

    # You can use an indexed key for choosing a maximum:
    biggest_y_point := Point(1, 2) _max_.y Point(999, 0)
    assert biggest_y_point == Point(???, ???)

    shortest_list := [1, 2, 3] _min_.length [99, 100] 
    assert shortest_list == [???]

    # You can also use a method for choosing a maximum:
    biggest_magnitude := 5 _max_.abs() -999
    assert biggest_magnitude == ???
