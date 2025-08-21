return {
  {
    {
      "yetone/avante.nvim",
      enabled = false,
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",  -- ⚠️ must add this line! ! !
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      opts = {
        -- mode = "legacy",
        -- add any opts here
        -- for example
        provider = "copilot",
        providers = {
          copilot = {
            model = "claude-sonnet-4",
          },
        },
        auto_suggestions_provider = "aihubmix",
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub and hub:get_active_servers_prompt() or ""
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
        disabled_tools = {
          "list_files",    -- Built-in file operations
          "search_files",
          "read_file",
          "create_file",
          "rename_file",
          "delete_file",
          "create_dir",
          "rename_dir",
          "delete_dir",
          "bash",         -- Built-in terminal access
        },
        input = {
          provider = "snacks",
          provider_opts = {
            -- Additional snacks.input options
            title = "Avante Input",
            icon = " ",
          },
        },
        behaviour = {
          auto_suggestions = true, -- Experimental stage
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
          minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
          enable_token_counting = true, -- Whether to enable token counting. Default to true.
          auto_approve_tool_permissions = true, -- Default: show permission prompts for all tools
          -- Examples:
          -- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
          -- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
        },
        -- providers = {
        --   claude = {
        --     endpoint = "https://api.anthropic.com",
        --     model = "claude-sonnet-4-20250514",
        --     timeout = 30000, -- Timeout in milliseconds
        --     extra_request_body = {
        --       temperature = 0.75,
        --       max_tokens = 20480,
        --     },
        --   },
        -- },
      },
      -- config = function( opts)
      --   -- require the avante module
      --   require("avante").setup({
      --     -- system_prompt as function ensures LLM always has latest MCP server state
      --     -- This is evaluated for every message, even in existing chats
      --     system_prompt = function()
      --       local hub = require("mcphub").get_hub_instance()
      --       return hub and hub:get_active_servers_prompt() or ""
      --     end,
      --     -- Using function prevents requiring mcphub before it's loaded
      --     custom_tools = function()
      --       return {
      --         require("mcphub.extensions.avante").mcp_tool(),
      --       }
      --     end,
      --   })
      -- end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "stevearc/dressing.nvim", -- for input provider dressing
        "folke/snacks.nvim", -- for input provider snacks
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    }
  },
}
