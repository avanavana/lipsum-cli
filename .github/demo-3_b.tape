Output .github/demo-3_b.gif

Require lipsum
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
Type "export HOME=/tmp/lipsum-demo-3"
Enter
Type "export PATH=$PWD:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
Enter
Type "export EDITOR=true"
Enter
Type "rm -rf /tmp/lipsum-demo-3"
Enter
Type "mkdir -p ~/.lipsum ~/.lipsum/templates"
Enter
Type "cp share/lorem.words ~/.lipsum/words"
Enter
Type "clear"
Enter
Sleep 120ms
Show

Type "lipsum-cli has its own powerful templating language for structured placeholder content..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "cat examples/templates/conventional-commit.tpl"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Save templates you use frequently as custom identifiers..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum template new conventional-commit --from examples/templates/conventional-commit.tpl"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "And generate structured placeholder content with them at the drop of a hat..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 3 template conventional-commit"
Enter
Sleep 2800ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Model any format you need by creating a *.tpl template file..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "cat examples/templates/social-media-post-ndjson.tpl"
Enter
Sleep 2400ms

Type "lipsum template new social-media --from examples/templates/social-media-post-ndjson.tpl"
Enter
Sleep 2400ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Then use it to generate placeholder content..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 3 template social-media"
Enter
Sleep 3000ms

Hide
Type "clear"
Enter
Sleep 120ms
Show
Type "Choose different output formats for markup and APIs..."
Sleep 1400ms
Hide
Ctrl+U
Type "clear"
Enter
Sleep 120ms
Show
Type "lipsum 4 lines --ordered-list --format html"
Enter
Sleep 2600ms
