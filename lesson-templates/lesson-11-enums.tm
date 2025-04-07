# Enums

# Enums define a type with multiple possible variants:
enum Shape(Circle(radius: Num), Rectangle(width: Num, height: Num), Point)

    # Use `when` to pattern match an enum:
    func area(shape: Shape -> Num)
        when shape is Circle(radius)
            return Num.PI * radius^2
        is Rectangle(width, height)
            return width * height
        is Point
            return 0

func main()

    # You can create instances of an enum:
    point := Shape.Point

    # Single member enums display without the field names:
    circle := Shape.Circle(radius=10)
    >> circle
    = Shape.Circle(10)

    # Multi-member enums explicitly list their field names:
    rect := Shape.Rectangle(width=4, height=5)
    >> rect
    = Shape.Rectangle(width=4, height=5)

    >> point.area()
    = ???

    >> rect.area()
    = ???

    >> "My shape is $circle"
    = ???
