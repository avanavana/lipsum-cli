Output .github/demo-2.gif

Require lipsum
Require lipsumize
Require printf
Require cat

Set Shell "zsh"
Set FontFamily "Hack"
Set FontSize 24
Set Theme "Dracula"
Set Width 1200
Set Height 920
Set Padding 20
Set Margin 20
Set MarginFill "#737373"
Set BorderRadius 10
Set TypingSpeed 40ms

Hide
Type "DEMO_HOME=$(mktemp -d)"
Enter
Type "mkdir -p $DEMO_HOME/.lipsum"
Enter
Type "cp -R ~/.lipsum/sources $DEMO_HOME/.lipsum/"
Enter
Type "cp ~/.lipsum/words $DEMO_HOME/.lipsum/words"
Enter
Type "mkdir -p $DEMO_HOME/.lipsum/templates"
Enter
Type "export HOME=$DEMO_HOME"
Enter
Type "export PATH=/usr/local/bin:$PATH"
Enter
Type "export PS1='%F{#737373}> %f'"
Enter
Show

Type "Generate lipsum with built-in corpora: lorem, hipster, tech, pirate, food, corporate, es, fr, de..."
Sleep 1500ms
Ctrl+U

Type "lipsum --source hipster 8 words"
Enter
Sleep 2400ms

Type "Use text on-the-fly from the command line..."
Sleep 1200ms
Ctrl+U

Type "printf 'launch clear polished collaborative scalable secure flexible reliable modern friendly' | lipsum --text - 90 characters --punctuation end"
Enter
Sleep 2800ms

Type "Or save it as a reusable, named source..."
Sleep 1200ms
Ctrl+U

Type "printf 'launch clear polished collaborative scalable secure flexible reliable modern friendly' | lipsumize product-copy -"
Enter
Sleep 2800ms

Type "lipsum --source product-copy 110 characters --punctuation end"
Enter
Sleep 2600ms

Type "Use and save any source you like, even long-form content—the rabbit hole goes deep..."
Sleep 1500ms
Ctrl+U

Type "cat examples/alice.txt"
Enter
Sleep 3200ms

Type "lipsumize wonderland examples/alice.txt"
Enter
Sleep 2800ms

Type "lipsum sources wonderland"
Enter
Sleep 3200ms

Type "lipsum -s wonderland 4l -r 4-7 -b"
Enter
Sleep 2600ms
