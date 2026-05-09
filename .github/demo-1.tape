Output .github/demo-1.gif

Require lipsum

Set Shell "zsh"
Set FontFamily "Hack"
Set FontSize 24
Set Theme "Dracula"
Set Width 1200
Set Height 840
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
Type "cp ~/.lipsum/words $DEMO_HOME/.lipsum/words"
Enter
Type "export HOME=$DEMO_HOME"
Enter
Type "export PATH=/usr/local/bin:$PATH"
Enter
Type "export PS1='%F{#737373}> %f'"
Enter
Show

Type "Generate placeholder text for just about any need..."
Sleep 1200ms
Ctrl+U

Type "lipsum 8 words"
Enter
Sleep 2200ms

Type "lipsum 3 lines --range 4-6 --bullets"
Enter
Sleep 2400ms

Type "lipsum 4 lines --range 3-5 --ordered-list '(%A)'"
Enter
Sleep 2600ms

Type "lipsum 2-3l -r 3-4 -o '%00z)' -p none"
Enter
Sleep 2800ms

Type "Even generate lipsum with emoji..."
Sleep 1200ms
Ctrl+U

Type "lipsum 100 characters --emoji --punctuation end"
Enter
Sleep 2600ms
