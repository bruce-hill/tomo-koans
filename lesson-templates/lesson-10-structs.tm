# Structs and Methods

# The keyword `struct` is used to define structures
# that hold multiple members:
struct Point(x:Int, y:Int):

    # Methods are any function defined inside of the
    # indented area below a struct definition.

    # There is no implicit `self` argument, only the
    # arguments you explicitly define.
    func absolute(p:Point -> Point):
        return Point(p.x:abs(), p.y:abs())
    
    # Constants can be declared inside of a struct's namespace:
    ZERO := Point(0, 0)

    # Arbitrary functions can also be defined here:
    func squared_int(x:Int -> Int):
        return x * x

func main():

    # You can create a struct instance like this:
    p := Point(x=3, y=4)

    >> p
    = Point(x=???, y=???)

    >> Point.ZERO
    = Point(x=???, y=???)

    >> p.x
    = ???
    >> p.y
    = ???

    >> p.sum()
    = ???

    >> Point.squared_int(5)
    = ???
