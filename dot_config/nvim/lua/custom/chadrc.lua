---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "vscode_dark",
  theme_toggle = { "vscode_dark" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal

    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "arrow",
    overriden_modules = nil,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
