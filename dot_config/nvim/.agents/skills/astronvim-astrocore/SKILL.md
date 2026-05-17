---
name: astronvim-astrocore
description: Enforce AstroNvim configuration standards, specifically ensuring AstroCore settings (mappings, options, features) are managed in lua/plugins/astrocore.lua. Use this when the user asks to modify AstroNvim core settings or mappings.
---

# AstroNvim AstroCore Management

This skill ensures that all configurations related to `astrocore` are centralized in the correct file to maintain a clean and organized AstroNvim setup.

## Standards

- **Centralization**: All `astrocore` configurations (mappings, vim options, autocommands, and features) MUST be defined in `lua/plugins/astrocore.lua`.
- **No Overrides**: Do not place `astrocore` overrides in `lua/plugins/user.lua` or other plugin files unless strictly necessary (e.g., a plugin that specifically needs to hook into AstroCore at runtime, which is rare).
- **Mapping Conflicts**: When adding new mappings that might conflict with AstroNvim or Neovim defaults, disable the conflicting mappings in `lua/plugins/astrocore.lua` by setting them to `false`.

## Workflow

1.  **Identify**: Determine if the requested change belongs to `astrocore` (e.g., a mapping starting with `g`, a vim option like `relativenumber`, or a core feature like `autopairs`).
2.  **Locate**: Open `lua/plugins/astrocore.lua`.
3.  **Apply**: Insert or modify the configuration within the `opts` table of the `AstroNvim/astrocore` spec.
4.  **Cleanup**: If an existing `astrocore` configuration exists in another file (like `user.lua`), move it to `astrocore.lua`.
