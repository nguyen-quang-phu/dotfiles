# 🛠️ dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

### Prerequisites

- [chezmoi](https://www.chezmoi.io/install/)
- [age](https://github.com/FiloSottile/age)
- [mise](https://mise.jdx.sh/)

### Installation

```bash
# Initialize chezmoi
chezmoi init --apply github.com/nguyen-quang-phu/dotfiles
```

## 📦 Features

- **Shell:** [Nushell](https://www.nushell.sh/) with custom environment and PATH configuration.
- **Editor:** Neovim (AstroNvim-based) with extensive LSP support and custom configurations.
- **Tools Management:** Handled by `mise` (Node.js, Lefthook, etc.).
- **Git Workflow:** 
  - Automated hooks using `lefthook`.
  - Commit message linting with `commitlint`.
  - Automatic push on commit.
- **Security:** Secrets (like SSH keys or git configs) are encrypted with `age`.

## ⌨️ Aliases

Custom script-based aliases located in `~/.local/bin`:

- `cz`: `chezmoi`
- `cza`: `chezmoi add`
- `czae`: `chezmoi add --encrypt`
- `czra`: `chezmoi re-add`
- `czap`: `chezmoi -v apply`
- `vim`: `nvim`
- `justg`: `just -g` (Global just)

## ⚙️ Components

- **Nushell (`dot_config/nushell`):** Environment and configuration for Nushell.
- **Sesh (`dot_config/sesh`):** Configuration for sesh (Smart Session Manager).
- **Espanso (`dot_config/espanso`):** Text expander configuration and matches.
- **Fcitx5 (`dot_config/private_fcitx5`):** Input method configuration.
- **Neovim (`dot_config/nvim`):** A customized AstroNvim setup with many LSPs configured.
- **Git (`dot_config/git`):** Encrypted identity configurations.
- **Hooks (`lefthook.yml`):** Pre-configured git hooks for a smooth development workflow.
- **Agent Skills (`.agents/skills`):** Custom skills for AI agents (Gemini CLI, Cursor, etc.).

## 📂 Chezmoi Conventions

This repository follows [chezmoi's source state attributes](https://www.chezmoi.io/reference/source-state-attributes):

- `dot_`: Files or directories starting with `dot_` will be created with a `.` prefix in the destination (e.g., `dot_zshrc` becomes `~/.zshrc`).
- `executable_`: Files prefixed with `executable_` will have executable permissions set (e.g., `executable_justg` becomes `~/.local/bin/justg` with `+x`).
- `.tmpl`: Files ending in `.tmpl` are processed as templates, allowing for dynamic content based on variables or scripts.

## 🔑 Encryption

This repository uses `age` for encryption. The script `run_onchange_before_decrypt-private-key.sh.tmpl` handles the decryption of sensitive files automatically when the decryption key is available in `~/.config/chezmoi/key.txt`.
