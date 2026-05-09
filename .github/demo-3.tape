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

Type "Generate structured placeholder content..."
Sleep 1200ms
Ctrl+U

Type "lipsum template new conventional-commit --from examples/templates/conventional-commit.tpl"
Enter
Sleep 2400ms

Type "lipsum 3 template conventional-commit --punctuation none"
Enter
Sleep 2800ms

Type "Model almost any format you need..."
Sleep 1300ms
Ctrl+U

Type "cat examples/templates/blog-post.tpl"
Enter
Sleep 2600ms

Type "lipsum template new blog-post --from examples/templates/blog-post.tpl"
Enter
Sleep 2200ms

Type "lipsum 2 template blog-post --format json"
Enter
Sleep 3000ms

Type "Generate output in formats for markup and APIs..."
Sleep 1200ms
Ctrl+U

Type "lipsum 3 template blog-post -f ndjson -p none"
Enter
Sleep 3000ms
