# Paths

func main()

    # Tomo includes a built-in literal type for file paths
    # A path is inside parentheses and begins with `/`, `~`, `.` or `..`

    path := (/tmp/test-file.txt)
    assert path == (/tmp/test-file.txt)

    path.write("first")
    assert path.read() == "???"

    path.append(",second")

    assert path.exists() == yes

    assert path.parent() == (/???)

    assert path.extension() == "???"

    assert path.parent().child("other-file.txt") == (/???)

    assert (/tmp/test-*.txt).glob() == [???]

    path.remove()

    assert path.exists() == ???

