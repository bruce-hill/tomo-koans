# Paths

func main():

    # Tomo includes a built-in literal type for file paths
    # A path is inside parentheses and begins with `/`, `~`, `.` or `..`

    path := (/tmp/test-file.txt)
    >> path
    = /tmp/test-file.txt

    path:write("first line")
    >> path:read()
    = "???"

    path:append("

        second line
    ")

    >> path:exists()
    = yes

    # You can iterate over a file by lines:
    >> upper_lines := [line:upper() for line in path:by_line()!]
    = [???]

    >> path:parent()
    = /???

    >> path:extension()
    = "???"

    >> path:parent():child("other-file.txt")
    = /???

    >> dir := (/tmp/test-*.txt):glob()
    = [???]

    path:remove()

    >> path:exists()
    = ???

