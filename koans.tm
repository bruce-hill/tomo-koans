# This is the Tomo koans program

_HELP := "tomo koans - A tutorial program for learning the Tomo programming language"

use colorful
use shell
use commands

editor := "vim"
user : Text?

LESSONS := [
    Lesson((./lessons/lesson-01-hello-world.tm), "Hello World", "Hello world\n"),
    Lesson((./lessons/lesson-02-tests.tm), "Testing Code"),
    Lesson((./lessons/lesson-03-variables.tm), "Variables"),
    Lesson((./lessons/lesson-04-functions.tm), "Functions"),
    Lesson((./lessons/lesson-05-basic-types.tm), "Basic Types"),
    Lesson((./lessons/lesson-06-arrays.tm), "Arrays"),
    Lesson((./lessons/lesson-07-optionals.tm), "Optionals"),
    Lesson((./lessons/lesson-08-tables.tm), "Tables"),
    Lesson((./lessons/lesson-09-text.tm), "Text"),
    Lesson((./lessons/lesson-10-structs.tm), "Structs"),
    Lesson((./lessons/lesson-11-enums.tm), "Enums"),
    Lesson((./lessons/lesson-12-allocating.tm), "Allocating Memory"),
    Lesson((./lessons/lesson-13-paths.tm), "File Paths"),
    Lesson((./lessons/lesson-14-langs.tm), "Embedded Languages"),
    Lesson((./lessons/lesson-15-min-max.tm), "Min and Max"),
    Lesson((./lessons/lesson-16-reducers.tm), "Reducers"),
]

enum TestResult(NotRun, Success(output:Text), Error(err:Text), WrongOutput(actual:Text, expected:Text))
    func print(result:TestResult)
        when result is NotRun
            pass
        is Success(s)
            $Colorful"
                @(b,u:Program Output:)
                @(green:$s)
            ".print()
        is Error(e)
            $Colorful"
                @(b,u:Program Errors:)

                $e
            ".print()
        is WrongOutput(actual, expected)
            $Colorful"
                @(b,u:Program Output:)
                @(red:$actual)
                @(b,u:Expected:)
                @(green:$expected)
            ".print()

    func is_success(result:TestResult -> Bool)
        when result is Success return yes
        else return no

struct Lesson(file:Path, description:Text, expected_output:Text?=none)
    func get_result(l:Lesson -> TestResult)
        result := $Shell"COLOR=1 tomo -O 0 $(l.file)".result()
        if not result.succeeded()
            return Error(Text.from_bytes(result.errors)!)

        output := Text.from_bytes(result.output)!
        if expected := l.expected_output
            if output != expected
                return WrongOutput(output, expected)

        return Success(output)

func ask_continue()
    _ := ask("\[2]Press Enter to continue...\[]", bold=no)

func clear_screen()
    say("\x1b[2J\x1b[H", newline=no)

func summarize_tests(results:[TestResult], highlight:Path?=none)
    $Colorful"
        
        @(yellow,b,u:Lessons)
    ".print()

    passing := 0
    failing := 0
    for i,lesson in LESSONS
        when results[i] is Success
            passing += 1
            $Colorful"
                @(green,bold:$(Text(i).left_pad(2)): "$(lesson.description)" (passes))
            ".print()
        is NotRun
            failing += 1
            $Colorful"
                @(dim:$(Text(i).left_pad(2)): "$(lesson.description)" (not yet attempted))
            ".print()
        else
            failing += 1
            $Colorful"
                @(red:$(Text(i).left_pad(2)): "$(lesson.description)" (failing))
            ".print()

    completed := Num(passing)/Num(passing+failing)
    $Colorful"

        @(cyan,b:Progress: $(completed.percent()))

    ".print()

func short_summarize_tests(results:[TestResult])
    say("Progress: ", newline=no)
    for result in results
        when result is Success
            $Colorful"@(green,bold:#)".print(newline=no)
        is NotRun
            $Colorful"@(dim:#)".print(newline=no)
        else
            $Colorful"@(red:#)".print(newline=no)

    say("\n")

func choose_option(options:{Text=Text} -> Text)
    repeat
        for k,v in options
            $Colorful"
                @(b:($k)) $v
            ".print()
        say("")
        choice := (ask("Choose an option: ") or goodbye()).lower().to(1)
        if options.has(choice)
            return choice
        else if choice == "q"
            goodbye()
        else
            $Colorful"
                @(red:I'm sorry, I don't recognize that choice, please try again!")
            ".print()
    fail("Unreachable")

func show_lesson(lesson:Lesson, result:TestResult)
    clear_screen()
    $Colorful"

        @(yellow,b,u:$(lesson.description))
        Here's what we have right now:

    ".print()

    result.print()
    when result is Success
        $Colorful"
            @(green,b:✨ Great job, this test is passing! ✨)

        ".print()
    is NotRun
        $Colorful"
            @(dim,italic:...nothing, edit the file to make your first attempt...)

        ".print()
    else
        $Colorful"
            @(red,b:Looks like this test isn't passing yet! 😢)

        ".print()

func goodbye(-> Abort)
    clear_screen()
    $Colorful"

        @(b:Goodbye! Come back again soon!)

    ".print()
    exit(code=0)

func give_feedback(section:Text)
    clear_screen()
    user = user or ask("What name do go by? (optional) ") or "anon"
    if user == "" then user = "anon"
    feedback := ask("What's your feedback? ") or return
    (./feedback.txt).append("
        [$(user!)/$section] $feedback\n
    ")

func main(clean=no -> Abort)
    clear_screen()
    $Colorful"
        
        @(bold,green:Hello and welcome to the Tomo Koans program!)

        We're going to run through some programs that don't work
        and you'll be fixing them up!

        I hope you have fun!

    ".print()

    if clean
        (./editor.txt).remove(ignore_missing=yes)
        (./lessons).remove(ignore_missing=yes)

    if (./editor.txt).exists()
        editor = (./editor.txt).read()!
        $Colorful"
            @(dim,i:You're using @(green:$(editor)) as your text editor. If you want to change it, just edit @(magenta:./editor.txt))

        ".print()
    else
        editor = ask("What command line text editor do you want to use? ") or goodbye()
        while editor == "" or not $Shell"command -v $editor >/dev/null".run().succeeded()
            editor = ask("I don't recognize that editor. Try again? ") or goodbye()
        (./editor.txt).write(editor)
        $Colorful"

            Great! From now on, I'll use @(b:$(editor)) to edit files.
            If you want to change it, just edit @(magenta:./editor.txt)

        ".print()

    $Shell"
        cp -r lesson-templates lessons
    ".run().or_fail("Could not make lessons directory")

    test_results := &[TestResult.NotRun for l in LESSONS]

    ask_continue()
    message_pending := no
    repeat
        unless message_pending
            clear_screen()
        message_pending = no

        summarize_tests(test_results)
        choice := ask("Choose a test, (q)uit, or give (f)eedback: ") or stop repeat
        stop repeat if choice == "q" or choice == "Q"

        if choice == "f" or choice == "F"
            give_feedback("menu")
            skip

        if choice == ""
            for i,result in test_results
                if not result.is_success()
                    choice = Text(i)
                    stop

        n := Int.parse(choice) or (do
            $Colorful"@(red:I don't know what that means! Type a test number or 'q'.)".print()
            message_pending = yes
            skip repeat
        )

        if n < 1 or n > LESSONS.length
            $Colorful"@(red:That's not a valid test number!)".print()
            message_pending = yes
            skip repeat

        repeat
            lesson := LESSONS[n]
            show_lesson(lesson, test_results[n])
            short_summarize_tests(test_results)

            options := &{
                "e"="Edit file and try again",
                "l"="Show the lesson list",
                "q"="Quit",
                "f"="Give Feedback",
            }
            if n < LESSONS.length
                options["n"] = "Go to the next lesson"

            when choose_option(options) is "e"
                $Shell"
                    $(editor) $(lesson.file)
                ".run().or_fail("Could not open editor $(editor)")

                test_results[n] = lesson.get_result()
                test_results[n].print()
            is "l"
                stop
            is "n"
                n += 1
            is "q"
                goodbye()
            is "f"
                give_feedback("lesson$n")

    goodbye()
