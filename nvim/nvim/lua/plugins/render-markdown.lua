return {
  "MeanderingProgrammer/render-markdown.nvim",
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = {
      sign = true,
      enabled = true,
      render_modes = false,
      signs = 'language',
      style = 'full',
      position = 'left',
      language_pad = 0,
      language_name = true,
      disable_background = { 'diff' },
      width = 'block',
      left_pad = 2,
      right_pad = 4,
      left_margin = 0,
      min_width = 45,
      border = 'thin',
      above = '▄',
      below = '▀',
      highlight = 'RenderMarkdownCode',
      highlight_language = nil,
      inline_pad = 0,
      highlight_inline = 'RenderMarkdownCodeInline',
    },
    heading = {
      enabled = true,
      render_modes = false,
      sign = true,
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      position = 'inline',
      signs = { '󰫎 ' },
      width = 'full',
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = false,
      border_virtual = false,
      border_prefix = false,
      above = '▄',
      below = '▀',
      backgrounds = {
        'RenderMarkdownH1Bg',
        'RenderMarkdownH2Bg',
        'RenderMarkdownH3Bg',
        'RenderMarkdownH4Bg',
        'RenderMarkdownH5Bg',
        'RenderMarkdownH6Bg',
      },
      foregrounds = {
        'RenderMarkdownH1',
        'RenderMarkdownH2',
        'RenderMarkdownH3',
        'RenderMarkdownH4',
        'RenderMarkdownH5',
        'RenderMarkdownH6',
      },
      custom = {},
    },
    dash = {
      enabled = true,
      render_modes = false,
      icon = '─',
      width = 'full',
      left_margin = 0,
      highlight = 'RenderMarkdownDash',
    },
    checkbox = {
      enabled = true,
      render_modes = false,
      position = 'inline',
      unchecked = {
        icon = '󰄱',
        highlight = 'ObsidianTodo',
        scope_highlight = nil,
      },
      checked = {
        icon = ' ',
        highlight = 'ObsidianDone',
        scope_highlight = '@markup.strikethrough',
      },
      -- [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "", hl_group = "ObsidianDone" },
      -- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      -- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      -- ["!"] = { char = "", hl_group = "ObsidianImportant" },
      custom = {
        todo = {
          raw = '[ ]',
          rendered = '◯ ',
          highlight = 'ObsidianTodo',
          scope_highlight = nil,
        },
        right_arrow = {
          raw = '[>]',
          rendered = ' ',
          highlight = "ObsidianRightArrow",
          scope_highlight = nil,
        },
        tilde = {
          raw = '[~]',
          rendered = '󰰱 ',
          highlight = "ObsidianTilde",
          scope_highlight = nil,
        },
        important = {
          raw = '[!]',
          highlight = "ObsidianImportant",
          rendered = ' ',
          scope_highlight = nil,
        },
      },
    },
    bullet = {
      enabled = true,
      render_modes = false,
      icons = { '●', '○', '◆', '◇' },
      ordered_icons = function(ctx)
        local value = vim.trim(ctx.value)
        local index = tonumber(value:sub(1, #value - 1))
        return string.format('%d.', index > 1 and index or ctx.index)
      end,
      left_pad = 0,
      right_pad = 0,
      highlight = 'RenderMarkdownBullet',
    },
  },
  config = function(opts)
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#313244' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#313244' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#313244' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#313244' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#313244' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#313244' })
    require('render-markdown').setup(opts)
  end,
}
