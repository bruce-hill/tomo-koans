# Paths

func main():

    # Tomo includes a built-in literal type for file paths
    # A path is inside parentheses and begins with `/`, `~`, `.` or `..`

    file := (/tmp/test-file.txt)
    >> file
    = /tmp/test-file.txt

    file:write("first line")
    >> file:read()
    = "???"

    file:append("

        second line
    ")

    >> file:exists()
    = yes

    >> file:lines()
    = [???]

    # You can iterate over a file by lines:
    >> upper_lines := [line:upper() for line in file:by_line()]
    = [???]

    >> file:parent()
    = /???

    >> file:extension()
    = "???"

    >> file:parent():child("other-file.txt")
    = /???

    >> dir := (/tmp/test-*.txt):glob()
    = [???]

    file:remove()

    >> file:exists()
    = ???

