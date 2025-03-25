# Enums

# Enums define a type with multiple possible variants:
enum Shape(Circle(radius: Num), Rectangle(width: Num, height: Num), Point):

    # Use `when` to pattern match an enum:
    func area(shape: Shape -> Num):
        when shape is Circle(radius):
            return Num.PI * radius * radius
        is Rectangle(width, height):
            return width * height
        is Point:
            return 0

func main():

    # You can create instances of an enum:
    s1 := Shape.Point

    # Single member enums display without the field names:
    s2 := Circle(radius=10)
    >> s1
    = Circle(10)

    # Multi-member enums explicitly list their field names:
    s3 := Shape.Rectangle(width=4, height=5)
    >> s3
    = Rectangle(width=4, height=5)

    >> s1:area()
    = ???

    >> s2:area()
    = ???

    >> "My shape is $s3"
    = ???
