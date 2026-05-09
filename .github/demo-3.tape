Output .github/demo-3.gif

Require lipsum
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
Type "export HOME=/tmp/lipsum-demo-3"
Enter
Type "export PATH=/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
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
Show
Type "Generate structured placeholder content..."
Sleep 1200ms
Ctrl+U

Type "cat examples/templates/conventional-commit.tpl"
Enter
Sleep 2400ms

Type "lipsum template new conventional-commit --from examples/templates/conventional-commit.tpl"
Enter
Sleep 2200ms

Type "lipsum 3 template conventional-commit --punctuation none"
Enter
Sleep 2800ms

Hide
Type "export EDITOR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/.github/vhs-template-editor.zsh'"
Enter
Type "clear"
Enter
Show
Type "Model almost any format you need..."
Sleep 1300ms
Ctrl+U

Type "lipsum template new social-media-post"
Enter
Sleep 2200ms

Type '{'
Enter
Type '  "author": "{{words(2)}}",'
Enter
Type '  "text": "{{sentence(6-12)}}",'
Enter
Type '  "likes": {{number(12-980)}}'
Enter
Type '}'
Enter
Ctrl+D
Sleep 2200ms

Type "lipsum 2 template social-media-post -p none"
Enter
Sleep 3000ms

Hide
Type "clear"
Enter
Show
Type "Generate output in formats for markup and APIs..."
Sleep 1200ms
Ctrl+U

Type "lipsum 4 lines --bullets --format html"
Enter
Sleep 2600ms

Type "lipsum 5 words --format ndjson --punctuation none"
Enter
Sleep 3000ms
