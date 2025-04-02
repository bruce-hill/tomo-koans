# Tables

func main():

    # Tables store key-value pairs.
    # You can define a table using `{key = value, ...}`.

    scores := {"Alice"=100, "Bob"=200}
    >> scores
    = {"Alice"=100, "Bob"=200}

    >> scores["Alice"]
    = ???

    # Accessing a missing key gives `none`
    >> scores["Zoltan"]
    = ???

    # Tables can be empty but must have key and value types:
    empty := {:Text=Int}
    >> empty
    = {:Text=Int}

    # You can loop over tables:
    total := 0
    for name, score in scores:
        total += score

    >> total
    = ???

    # Table keys and values can be accessed as an array:
    >> scores.keys
    = [???]

    >> scores.values
    = [???]

    # Table comprehensions let you create tables concisely:
    doubled := {k = v * 2 for k, v in scores}
    >> doubled
    = {???}
