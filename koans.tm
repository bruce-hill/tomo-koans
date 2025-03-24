#!/bin/env tomo

use colorful
use shell
use commands

editor := "vim"

enum TestResult(Success(output:Text), Error(err:Text), WrongOutput(actual:Text, expected:Text)):
    func print(result:TestResult):
        when result is Success(s):
            $Colorful"
                @(b,u:Program Output:)
                $s
            ":print()
        is Error(e):
            $Colorful"
                @(b,u:Program Errors:)

                $e
            ":print()
        is WrongOutput(actual, expected):
            $Colorful"
                @(b,u:Program Output:)
                @(red:$actual)
                @(b,u:Expected:)
                @(green:$expected)
            ":print()

    func is_success(result:TestResult -> Bool):
        when result is Success: return yes
        else: return no

struct Lesson(file:Path, description:Text, expected_output=none:Text):
    func get_result(l:Lesson -> TestResult):
        result := $Shell"COLOR=1 tomo -O 0 $(l.file)":result()
        if not result:succeeded():
            return Error(Text.from_bytes(result.stderr)!)

        output := Text.from_bytes(result.stdout)!
        if expected := l.expected_output:
            if output != l.expected_output:
                return WrongOutput(output, expected)

        return Success(output)

LESSONS := [
    Lesson((./lessons/lesson-01.tm), "Getting Started", "Hello world$\n"),
    Lesson((./lessons/lesson-02.tm), "Working with Text"),
]

func ask_continue():
    _ := ask("$\033[2mPress Enter to continue...$\033[m", bold=no)

func clear_screen():
    say("$\x1b[2J$\x1b[H", newline=no)

func summarize_tests(highlight=none:Path):
    $Colorful"
        
        @(yellow,b,u:Lessons)
    ":print()

    passing := 0
    failing := 0
    for i,lesson in LESSONS:
        result := lesson:get_result()
        if result:is_success():
            passing += 1
            $Colorful"
                @(green,bold:$(Text(i):left_pad(2)): "$(lesson.description)" (passes))
            ":print()
        else:
            failing += 1
            if lesson.file == highlight or (highlight == none:Path and failing == 1):
                $Colorful"
                    @(red:$(Text(i):left_pad(2)): "$(lesson.description)" (not yet passing))
                ":print()
            else:
                $Colorful"
                    @(dim:$(Text(i):left_pad(2)): "$(lesson.description)" (not yet passing))
                ":print()

    completed := (Num(passing)/Num(passing+failing))!
    $Colorful"

        @(cyan,b:Progress: $(completed:percent()))

    ":print()

func run_lesson(lesson:Lesson, result:TestResult -> TestResult):
    repeat:
        clear_screen()
        $Colorful"

            @(yellow,b,u:Lesson: "$(lesson.description)")
            Here's what we have right now:

        ":print()

        result:print()
        if result:is_success():
            $Colorful"
                @(green,b:✨ Great job, this test is passing! ✨)

            ":print()
        else:
            $Colorful"
                @(red,b:Looks like this test isn't passing yet! 😢)

            ":print()

        action := (ask("(e)dit the file and try again? Go (b)ack? Or (q)uit? ") or return result):lower()
        if action == "e" or action == "edit":
            $Shell"
                $(editor) $(lesson.file)
            ":run():or_fail("Could not open editor $(editor)")

            result = lesson:get_result()
            result:print()
        else if action == "b" or action == "back":
            stop
        else if action == "q" or action == "quit":
            goodbye()

    return result

func goodbye(-> Abort):
    clear_screen()
    $Colorful"

        @(b:Goodbye! Come back again soon!)

    ":print()
    exit(code=0)

func main(clean=no -> Abort):
    clear_screen()
    $Colorful"
        $\n@(bold,green:Hello and welcome to the Tomo Koans program!)

        We're going to run through some programs that don't work
        and you'll be fixing them up!

        I hope you have fun!

    ":print()

    if clean:
        (./editor.txt):remove()
        (./lessons):remove()

    if (./editor.txt):exists():
        editor = (./editor.txt):read()!
        $Colorful"
            @(dim,i:You're using @(green:$(editor)) as your text editor. If you want to change it, just edit @(magenta:./editor.txt))

        ":print()
    else:
        editor = ask("What command line text editor do you want to use? ")!
        (./editor.txt):write(editor)
        $Colorful"

            Great! From now on, I'll use @(b:$(editor)) to edit files.
            If you want to change it, just edit @(magenta:./editor.txt)

        ":print()

    $Shell"
        cp -r lesson-templates lessons
    ":run():or_fail("Could not make lessons directory")

    test_results := &[l:get_result() for l in LESSONS]

    ask_continue()
    repeat:
        clear_screen()
        summarize_tests()
        choice := ask("Choose a test or (q)uit: ") or stop repeat
        if choice == "q" or choice == "Q": stop repeat

        if choice == "":
            for i,result in test_results:
                if not result:is_success():
                    choice = Text(i)
                    stop

        n := Int.parse(choice) or (do:
            $Colorful"@(red:I don't know what that means! Type a test number or 'q'.)":print()
            skip repeat
        )

        if n < 1 or n > LESSONS.length:
            $Colorful"@(red:That's not a valid test number!)":print()
            skip repeat

        lesson := LESSONS[n]
        test_results[n] = run_lesson(lesson, test_results[n])
    
    goodbye()
