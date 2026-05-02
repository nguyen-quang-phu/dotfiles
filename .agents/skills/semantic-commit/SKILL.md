---
name: semantic-commit
description: Enforces a strict semantic commit message format (emoji, type, scope, subject, and body). Use this skill when generating or finalizing commit messages to ensure consistency and clarity in the repository's history.
---

# Semantic Commit Skill

This skill ensures every commit follows a standardized, descriptive format.

## Commit Message Format

Every commit message must consist of a header, an optional body, and optional footer.

```
<emoji> <type>(<scope>): <subject>

<body>
```

### 1. Header (Required)
- **Emoji**: Use an appropriate emoji representing the change.
- **Type**: Must be one of the following:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation only changes
  - `style`: Changes that do not affect the meaning of the code (white-space, formatting, etc.)
  - `refactor`: A code change that neither fixes a bug nor adds a feature
  - `perf`: A code change that improves performance
  - `test`: Adding missing tests or correcting existing tests
  - `build`: Changes that affect the build system or external dependencies
  - `ci`: Changes to CI configuration files and scripts
  - `chore`: Other changes that don't modify src or test files
  - `revert`: Reverts a previous commit
- **Scope**: A noun describing a section of the codebase (e.g., `nvim`, `chezmoi`, `bin`, `nushell`).
- **Subject**: A concise description of the change in the imperative mood (e.g., "add Nushell config" instead of "added Nushell config").

### 2. Body (Required)
The body must provide a **detailed description** of the change.
- Explain **why** the change was made.
- Describe the impact or technical details of the implementation.
- Use multiple lines if necessary.

## Common Emojis
- ✨ `feat`
- 🐛 `fix`
- 📝 `docs`
- 🚀 `perf` / `release`
- 🔧 `config` / `chore`
- ♻️ `refactor`
- 🧪 `test`
- 👷 `ci`
- 📦 `build`

## Workflow

1. **Analyze Changes**: Review `git diff --staged` to understand what is being committed.
2. **Determine Metadata**:
   - Identify the most relevant **type** and **scope**.
   - Select the matching **emoji**.
3. **Draft Header**: Construct the `<emoji> <type>(<scope>): <subject>` line.
4. **Draft Body**: Write at least 2-3 sentences explaining the "why" and "how".
5. **Verify**: Ensure the full message is descriptive and follows the format.

---
**Note**: After committing changes that affect repository features or aliases, remember to invoke the `readme-sync` skill to update the `README.md`.
