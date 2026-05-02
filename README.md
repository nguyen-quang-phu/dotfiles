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

- **Editor:** Neovim (AstroNvim-based) with extensive LSP support and custom configurations.
- **Tools Management:** Handled by `mise` (Node.js, Lefthook, etc.).
- **Git Workflow:** 
  - Automated hooks using `lefthook`.
  - Commit message linting with `commitlint`.
  - Automatic push on commit.
- **Security:** Secrets (like SSH keys or git configs) are encrypted with `age`.

## ⚙️ Components

- **Neovim (`dot_config/nvim`):** A customized AstroNvim setup with many LSPs configured.
- **Git (`dot_config/git`):** Encrypted identity configurations.
- **Hooks (`lefthook.yml`):** Pre-configured git hooks for a smooth development workflow.

## 🔑 Encryption

This repository uses `age` for encryption. The script `run_onchange_before_decrypt-private-key.sh.tmpl` handles the decryption of sensitive files automatically when the decryption key is available in `~/.config/chezmoi/key.txt`.
