# Contributing

## Branch naming

Use conventional branch names that mirror conventional commit types:

```text
<type>/<description>
<type>/<scope>/<description>
```

Allowed types:

- `feat`
- `fix`
- `docs`
- `style`
- `refactor`
- `perf`
- `test`
- `build`
- `ci`
- `chore`
- `revert`
- `release`

Branch naming rules:

- Use lowercase only.
- Separate words with hyphens.
- Use additional path segments only when they add clarity.

Examples:

- `feat/output-formats`
- `fix/template-json-rendering`
- `docs/release-workflow`
- `ci/semantic-release`
- `chore/dependency-updates`

## Commits

Use conventional commits. Release automation derives version bumps and changelog entries from commit messages.

Examples:

- `feat: add html output renderer`
- `fix: preserve punctuation before trailing emoji`
- `docs: explain template placeholders`
