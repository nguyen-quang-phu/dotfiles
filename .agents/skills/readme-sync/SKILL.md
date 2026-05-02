---
name: readme-sync
description: Ensures README.md is always up-to-date with the current tools, aliases, and features in the dotfiles repository. Use this skill whenever a tool is added/removed, an alias is created/deleted, or a major component is modified.
---

# README Sync Skill

This skill ensures that the project's `README.md` remains the "source of truth" for the repository's features and configuration.

## Workflow

When a change is made to the dotfiles (e.g., adding an alias, tool, or config), follow these steps:

1. **Identify the Change**: 
   - **Aliases**: Check `dot_local/bin/` for new `executable_*` files.
   - **Tools**: Check `mise.toml` or `package.json` for added/removed dependencies.
   - **Features**: Check `dot_config/` for new application configurations.
2. **Locate the Section**: Find the appropriate section in `README.md` (`## 📦 Features`, `## ⚙️ Components`, or a new `## ⌨️ Aliases` section).
3. **Apply the Update**:
   - For **Aliases**: Add a bullet point to the `Aliases` section describing the command and its function.
   - For **Tools**: Update the `Features` or `Prerequisites` section.
   - For **Components**: Update the `Components` section.
4. **Consistency Check**: Ensure the descriptions are concise and follow the existing tone of the document.

## Section Guidelines

### 📦 Features
List high-level capabilities. If a new major tool (like a new shell or a major Neovim plugin category) is added, describe it here.

### ⌨️ Aliases
List scripts in `~/.local/bin`.
Format: `- \`alias_name\`: Description of what it does (e.g., \`cz\` -> \`chezmoi\`).`

### ⚙️ Components
List directories in `dot_config/` that represent major pieces of the environment (e.g., Neovim, Git, Kitty).

### 🚀 Quick Start
If a new prerequisite is added to the setup, update this section.
