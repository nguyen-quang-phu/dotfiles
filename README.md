# Dotfiles

My personal dotfiles repository containing configuration files for various development tools and applications.

## Overview

This repository contains configuration files for a wide range of tools and applications I use in my development workflow. The configurations are organized by tool/application name.

## Contents

### Terminal & Shell
- **atuin** - Shell history management
- **direnv** - Environment variable management
- **zsh** - Shell configuration (via various tools)

### Terminal Emulators
- **ghostty** - Terminal emulator configuration
- **kitty** - Terminal emulator configuration

### Text Editors & IDEs
- **nvim** - Neovim configuration (Lua-based)

### File Management
- **yazi** - Terminal file manager with plugins
- **fd** - Fast file finder configuration
- **ripgrep** - Fast text search tool configuration

### Git
- **git** - Git configuration with aliases and settings
- **lazygit** - Terminal UI for Git

### Window Management & UI
- **sketchybar** - macOS status bar with plugins
- **karabiner** - Keyboard customization for macOS
- **zellij** - Terminal workspace manager

### Development Tools
- **bat** - Syntax highlighting for cat
- **pet** - Command-line snippet manager
- **pgcli** - PostgreSQL CLI client configuration
- **spotify-player** - Terminal Spotify player

### Text Expansion
- **espanso** - Text expansion tool

### Other Tools
- **tmux** - Terminal multiplexer
- **raycast** - macOS productivity app extensions
- **lumin** - Additional configuration
- **zathura** - PDF viewer configuration
- **keynold-scripts** - Keyboard-related scripts

## Installation

This repository uses a directory structure where each tool has its own folder. To use these configurations:

1. Clone this repository:
   ```bash
   git clone git@github.com:nguyen-quang-phu/dotfiles.git ~/dotfiles
   ```

2. Create symlinks to the appropriate configuration directories. For example:
   ```bash
   # For Zellij
   stow zellij
   ```

3. Or use a dotfiles manager like [GNU Stow](https://www.gnu.org/software/stow/) or [chezmoi](https://www.chezmoi.io/).

## Structure

```
dotfiles/
├── atuin/          # Shell history
├── bat/            # File viewer
├── direnv/         # Environment variables
├── espanso/        # Text expansion
├── fd/             # File finder
├── ghostty/        # Terminal emulator
├── git/            # Git configuration
├── karabiner/      # Keyboard customization
├── keynold-scripts/# Keyboard scripts
├── kitty/          # Terminal emulator
├── lazygit/        # Git TUI
├── lumin/          # Additional configs
├── nvim/           # Neovim configuration
├── pet/            # Snippet manager
├── pgcli/          # PostgreSQL CLI
├── raycast/        # macOS app extensions
├── ripgrep/        # Text search
├── sketchybar/     # macOS status bar
├── spotify-player/ # Spotify player
├── tmux/           # Terminal multiplexer
├── yazi/           # File manager
├── zathura/        # PDF viewer
└── zellij/         # Terminal workspace
```

## Notes

- Some configurations may be macOS-specific (e.g., sketchybar, karabiner)
- Git configuration includes conditional includes for different project directories
- Neovim configuration appears to be using a Lua-based setup
- Some paths in configurations may reference Nix store paths, indicating NixOS/Nix usage

## License

Personal dotfiles - use at your own discretion.

## Contributing

This is a personal dotfiles repository. Feel free to fork and adapt for your own use!
