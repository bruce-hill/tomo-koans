# Functions

func main():

    # Functions can be declared in any order.
    # The main() function is the first function to run,
    # but it can call any other functions defined in
    # the same file.

    # Here, we're calling a function defined below.
    # Fix up the function so it passes thes tests:
    >> add(5, 10)
    = 15
    >> add(2, 4)
    = 6

    # Functions can also be called with keyword arguments:
    >> add(x=4, y=12)
    = 16

# Functions are defined using `func` and must specify
# the types of their arguments and return values like this:
func add(x:Int, y:Int -> Int):

    # Fix this so it returns a sensible result:
    return ???
