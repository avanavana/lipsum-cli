Output .github/demo-2.gif

Require lipsum
Require lipsumize
Require printf
Require cat

Set FontFamily "Menlo"
Set FontSize 24
Set LetterSpacing 0
Set Theme "Dracula"
Set Width 1200
Set Height 920
Set Padding 20
Set Margin 20
Set MarginFill "#737373"
Set BorderRadius 10
Set TypingSpeed 40ms

Hide
Type "export HOME=/tmp/lipsum-demo-2"
Enter
Type "export PATH=/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
Enter
Type "rm -rf /tmp/lipsum-demo-2"
Enter
Type "mkdir -p ~/.lipsum ~/.lipsum/sources"
Enter
Type "cp share/lorem.words ~/.lipsum/words"
Enter
Type "clear"
Enter
Show
Type "# Generate lipsum with 9 built-in flavors of ipsum..."
Enter
Type "lipsum sources --names"
Enter
Sleep 2400ms

Type "lipsum --source hipster 8 words"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Show
Type "Use text on-the-fly from the command line..."
Sleep 1200ms
Ctrl+U

Type "lipsum --text 'Friendly onboarding makes products feel calmer while helpful hints keep people moving.' 1 sentence --range 6-8"
Enter
Sleep 2800ms

Hide
Type "clear"
Enter
Show
Type "Or save it as a reusable, named source..."
Sleep 1200ms
Ctrl+U

Type "printf 'launch clear polished collaborative scalable secure flexible reliable modern friendly' | lipsumize product-copy -"
Enter
Sleep 2800ms

Type "lipsum --source product-copy 2 lines --range 3-4 --bullets"
Enter
Sleep 2600ms

Hide
Type "clear"
Enter
Show
Type "Use and save any source you like, even long-form content—the rabbit hole goes deep..."
Sleep 1500ms
Ctrl+U

Type "cat examples/alice.txt"
Enter
Sleep 3200ms

Hide
Type "clear"
Enter
Show
Type "Source lipsum from any text file..."
Sleep 1200ms
Ctrl+U

Type "lipsumize wonderland examples/alice.txt"
Enter
Sleep 2800ms

Type "lipsum sources wonderland"
Enter
Sleep 3200ms

Type "lipsum -s wonderland 4l -r 4-7 -b"
Enter
Sleep 2600ms
