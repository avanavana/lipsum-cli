Output .github/demo-1.gif

Require lipsum

Set FontFamily "Menlo"
Set FontSize 24
Set LetterSpacing 0
Set Theme "Dracula"
Set Width 1200
Set Height 840
Set Padding 20
Set Margin 20
Set MarginFill "#737373"
Set BorderRadius 10
Set TypingSpeed 40ms

Hide
Type "export HOME=/tmp/lipsum-demo-1"
Enter
Type "export PATH=$PWD:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
Enter
Type "cat >/tmp/lipsum-demo-1-config <<'EOF'"
Enter
Type "emoji_charset='😀 😀 😀 😀 😀'"
Enter
Type "EOF"
Enter
Type "export LIPSUM_CONFIG=/tmp/lipsum-demo-1-config"
Enter
Type "rm -rf /tmp/lipsum-demo-1"
Enter
Type "mkdir -p ~/.lipsum"
Enter
Type "cp share/lorem.words ~/.lipsum/words"
Enter
Type "clear"
Enter
Sleep 120ms
Show

Type "Generate placeholder text for just about any need..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 8 words"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Generate placeholder lists and copy any output to clipboard..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 3 lines --range 4-6 --bullets --copy"
Enter
Sleep 2600ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "As well as ordered lists..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 4 lines --range 3-5 --ordered-list"
Enter
Sleep 2600ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Specify custom formats for list markers..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 2-3l -r 3-4 -o '%00z)'"
Enter
Sleep 2800ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Even generate lipsum with emoji..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 160ms
Show
Type "lipsum 100 characters --emoji 1.0 --punctuation end"
Enter
Sleep 2800ms
