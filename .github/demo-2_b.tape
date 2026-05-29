Output .github/demo-2_b.gif

Require lipsum
Require lipsumize
Require cat

Set FontFamily "Menlo"
Set FontSize 24
Set LetterSpacing 0
Set Theme "Dracula"
Set Width 1200
Set Height 920
Set Padding 20
Set Margin 40
Set MarginFill "#1e1f29"
Set BorderRadius 10
Set TypingSpeed 40ms

Hide
Type "export HOME=/tmp/lipsum-demo-2"
Enter
Type "export PATH=$PWD:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
Enter
Type "rm -rf /tmp/lipsum-demo-2"
Enter
Type "mkdir -p ~/.lipsum ~/.lipsum/sources"
Enter
Type "cp share/lorem.words ~/.lipsum/words"
Enter
Type "clear"
Enter
Sleep 120ms
Show

Type "lipsum-cli comes with 9 built-in flavors of lipsum..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum sources --names"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Generate placeholder text using the flavor of your choice..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum --source hipster 8 words"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Create your own flavor using inline (or piped!) text..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum --text 'Friendly onboarding makes products feel calmer while helpful hints keep people moving.' 1 sentence --range 6-8"
Enter
Sleep 2800ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Save custom flavors for quick usage later..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "printf 'launch clear polished collaborative scalable secure flexible reliable modern friendly' | lipsumize product-copy -"
Enter
Sleep 2800ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Use your saved custom flavors to generate lipsum in any format..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum --source product-copy 2 lines --range 3-4 --bullets"
Enter
Sleep 2600ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Even source lipsum from any text file..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsumize wonderland examples/alice.txt"
Enter
Sleep 2800ms

Type "lipsum sources wonderland"
Enter
Sleep 3200ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "The rabbit hole runs deep..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum -s wonderland 4l -r 4-7 -b"
Enter
Sleep 2800ms
