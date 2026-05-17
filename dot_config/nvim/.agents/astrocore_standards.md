# AstroNvim AstroCore Standards

All AI agents working on this project must follow these rules for configuration management:

## 1. Centralized AstroCore Configuration
All settings related to `astrocore` (mappings, vim options, autocommands, and core features) **MUST** be placed in:
`lua/plugins/astrocore.lua`

**Do not** add `astrocore` overrides or configurations in:
- `lua/plugins/user.lua`
- `lua/plugins/astrolsp.lua`
- Any other plugin files

## 2. Handling Mapping Conflicts
If an agent adds a new mapping that conflicts with a Neovim or AstroNvim default:
1. Identify the conflicting mapping.
2. Disable the default mapping in `lua/plugins/astrocore.lua` by setting it to `false`.
3. Example:
   ```lua
   mappings = {
     n = {
       gt = false, -- Disable default tab navigation for custom operator
     },
   }
   ```

## 3. Preservation of Structure
Always respect the existing table structure in `lua/plugins/astrocore.lua`. Do not overwrite the entire file; use surgical edits.
