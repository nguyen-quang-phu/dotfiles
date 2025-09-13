return {
    {
  "zerochae/endpoint.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = {
    "Endpoint",
  },
  config = function()
    require("endpoint").setup({
      -- Framework configuration
      framework = "auto", -- "auto", "spring", "nestjs", "symfony", "fastapi", "django", "rails", "express"

      -- Optional: Path-based framework overrides
      -- framework_paths = {
      --   ["/path/to/spring/project"] = "spring",
      --   ["/path/to/nestjs/project"] = "nestjs",
      --   ["/path/to/symfony/project"] = "symfony",
      --   ["/path/to/fastapi/project"] = "fastapi",
      -- },

      -- Cache configuration
      cache_mode = "none", -- Cache mode: "none" (real-time), "session", or "persistent"
      debug = false, -- Enable debug logging

      -- Picker configuration (optional)
      picker = "auto", -- "auto", "telescope", "vim_ui_select"

      ui = {
        show_icons = true,     -- Show method icons
        show_method = true,    -- Show method text (GET, POST, etc.)
        use_nerd_font = false, -- Use nerd font glyphs instead of emojis

        -- Customize icons (requires show_icons = true)
        method_icons = {
          emoji = {
            GET    = "📥",
            POST   = "📤",
            PUT    = "✏️",
            DELETE = "🗑️",
            PATCH  = "🔧",
          },
          nerd_font = {
            GET    = "",  -- download icon
            POST   = "",  -- upload icon
            PUT    = "",   -- edit icon
            DELETE = "", -- trash icon
            PATCH  = "",  -- wrench icon
          },
        },

        -- Customize colors
        method_colors = {
          GET    = "DiagnosticOk",      -- Green
          POST   = "DiagnosticInfo",    -- Blue
          PUT    = "DiagnosticWarn",    -- Yellow
          DELETE = "DiagnosticError",   -- Red
          PATCH  = "DiagnosticHint",    -- Purple
        },

        -- Cache status UI customization
        cache_status_icons = {
          emoji = {
            title = "🚀", success = "✅", error = "❌",
            tree = "🌳", directory = "📁", file = "📄"
          },
          nerd_font = {
            title = "", success = "", error = "",
            tree = "", directory = "", file = ""
          },
        },

        -- Cache status syntax highlighting
        cache_status_highlight = {
          title = "Special",
          success = "DiagnosticOk",
          error = "DiagnosticError",
          key = "Keyword",
          tree_method = "Function",
        },
      },
    })
  end,
}
  }
