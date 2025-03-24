#!/bin/env tomo

use colorful
use shell
use commands

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

func main(clean=no):
    clear_screen()
    $Colorful"
        $\n@(bold,green:Hello and welcome to the Tomo Koans program!)

        We're going to run through some programs that don't work
        and you'll be fixing them up!

        I hope you have fun!

    ":print()

    editor := if (./editor.txt):exists():
        (./editor.txt):read()!
    else:
        e := ask("What command line text editor do you want to use? ")!
        (./editor.txt):write(e)
        e

    $Colorful"You're using @(b:$editor)$\n":print()

    if clean:
        (./lessons):remove()

    $Shell"
        cp -r lesson-templates lessons
    ":run():or_fail("Could not make lessons directory")

    test_results := &[l:get_result() for l in LESSONS]

    repeat:
        ask_continue()
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
        clear_screen()

        repeat:
            $Colorful"

                @(yellow,b,u:Lesson $n: "$(lesson.description)")
                Here's what we have right now:

            ":print()

            result := lesson:get_result()
            test_results[n] = result
            result:print()
            if result:is_success():
                stop repeat

            summarize_tests(highlight=lesson.file)
            action := ask("That didn't go so well. (e)dit the file and try again? Or (Q)uit? ")
            if action:
                if action:lower() == "e":
                    $Shell"
                        $editor $(lesson.file)
                    ":run():or_fail("Could not open editor $editor")
                    skip repeat

            $Colorful"Goodbye! Come back again soon!":print()
            return

        $Colorful"
            @(green,b:✨ Good job, that succeeded! ✨)

        ":print()
    
    clear_screen()
    $Colorful"@(b:Goodbye! Come back again soon!)":print()
