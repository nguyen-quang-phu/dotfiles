-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      terminal = {
        enabled = true,
        win = {
          keys = {
            -- nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
            -- nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            -- nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            -- nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
            -- hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
            -- hide_underscore = { "<c-_>", "hide", desc = "which_key_ignore", mode = "t" },
          },
        },
      },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      { "<c-/>",      function() require("snacks").terminal() end, desc = "Toggle Terminal"},
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            require("snacks").debug.inspect(...)
          end
          _G.bt = function()
            require("snacks").debug.backtrace()
          end

          -- Override print to use snacks for `:=` command
          if vim.fn.has("nvim-0.11") == 1 then
            vim._print = function(_, ...)
              dd(...)
            end
          else
            vim.print = _G.dd 
          end

          -- Create some toggle mappings
          require("snacks").toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          require("snacks").toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          require("snacks").toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          require("snacks").toggle.diagnostics():map("<leader>ud")
          require("snacks").toggle.line_number():map("<leader>ul")
          require("snacks").toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          require("snacks").toggle.treesitter():map("<leader>uT")
          require("snacks").toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          require("snacks").toggle.inlay_hints():map("<leader>uh")
          require("snacks").toggle.indent():map("<leader>ug")
          require("snacks").toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      integrations = {
        sandwich = false,
        noice = true,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },
  {
    "alexpasmantier/tv.nvim",
    config = function()
      -- built-in niceties
      local h = require("tv").handlers

      require("tv").setup({
        -- global window appearance (can be overridden per channel)
        window = {
          width = 0.8, -- 80% of editor width
          height = 0.8, -- 80% of editor height
          border = "none",
          title = " tv.nvim ",
          title_pos = "center",
        },
        -- per-channel configurations
        channels = {
          -- `files`: fuzzy find files in your project
          files = {
            keybinding = "<leader>ff", -- Launch the files channel
            -- what happens when you press a key
            handlers = {
              ["<CR>"] = h.open_as_files, -- default: open selected files
              ["<C-q>"] = h.send_to_quickfix, -- send to quickfix list
              ["<C-s>"] = h.open_in_split, -- open in horizontal split
              ["<C-v>"] = h.open_in_vsplit, -- open in vertical split
              ["<C-y>"] = h.copy_to_clipboard, -- copy paths to clipboard
            },
          },

          -- `text`: ripgrep search through file contents
          text = {
            keybinding = "<leader>fw",
            handlers = {
              ["<CR>"] = h.open_at_line, -- Jump to line:col in file
              ["<C-q>"] = h.send_to_quickfix, -- Send matches to quickfix
              ["<C-s>"] = h.open_in_split, -- Open in horizontal split
              ["<C-v>"] = h.open_in_vsplit, -- Open in vertical split
              ["<C-y>"] = h.copy_to_clipboard, -- Copy matches to clipboard
            },
          },

          -- `git-log`: browse commit history
          ["git-log"] = {
            keybinding = "<leader>gl",
            handlers = {
              -- custom handler: show commit diff in scratch buffer
              ["<CR>"] = function(entries, config)
                if #entries > 0 then
                  vim.cmd("enew | setlocal buftype=nofile bufhidden=wipe")
                  vim.cmd("silent 0read !git show " .. vim.fn.shellescape(entries[1]))
                  vim.cmd("1delete _ | setlocal filetype=git nomodifiable")
                  vim.cmd("normal! gg")
                end
              end,
              -- copy commit hash to clipboard
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- `git-branch`: browse git branches
          ["git-branch"] = {
            keybinding = "<leader>gb",
            handlers = {
              -- checkout branch using execute_shell_command helper
              -- {} is replaced with the selected entry
              ["<CR>"] = h.execute_shell_command("git checkout {}"),
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- `docker-images`: browse images and run containers
          ["docker-images"] = {
            keybinding = "<leader>di",
            window = { title = " Docker Images " },
            handlers = {
              -- run a container with the selected image
              ["<CR>"] = function(entries, config)
                if #entries > 0 then
                  vim.ui.input({
                    prompt = "Container name: ",
                    default = "my-container",
                  }, function(name)
                      if name and name ~= "" then
                        local cmd = string.format("docker run -it --name %s %s", name, entries[1])
                        vim.cmd("!" .. cmd)
                      end
                    end)
                end
              end,
              -- copy image name
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- `env`: search environment variables
          env = {
            keybinding = "<leader>ev",
            handlers = {
              ["<CR>"] = h.insert_at_cursor, -- Insert at cursor position
              ["<C-l>"] = h.insert_on_new_line, -- Insert on new line
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- `aliases`: search shell aliases
          alias = {
            keybinding = "<leader>al",
            handlers = {
              ["<CR>"] = h.insert_at_cursor,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },
        },
        -- path to the tv binary (default: 'tv')
        tv_binary = "tv",
        global_keybindings = {
          channels = "<leader>tv", -- opens the channel selector
        },
        quickfix = {
          auto_open = true, -- automatically open quickfix window after populating
        },
      })
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cond = vim.g.neovide == nil,
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
    },
    specs = {
      -- disable mini.animate cursor
      {
        "nvim-mini/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
  { "ldelossa/litee.nvim", lazy = true },
  {
    "ldelossa/gh.nvim",
    opts = {},
    config = function(_, opts)
      require("litee.lib").setup()
      require("litee.gh").setup(opts)
    end,
    keys = {
      { "<leader>G", "", desc = "+Github" },
      { "<leader>Gc", "", desc = "+Commits" },
      { "<leader>Gcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
      { "<leader>Gce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
      { "<leader>Gco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
      { "<leader>Gcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
      { "<leader>Gcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
      { "<leader>Gi", "", desc = "+Issues" },
      { "<leader>Gip", "<cmd>GHPreviewIssue<cr>", desc = "Preview" },
      { "<leader>Gio", "<cmd>GHOpenIssue<cr>", desc = "Open" },
      { "<leader>Gl", "", desc = "+Litee" },
      { "<leader>Glt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
      { "<leader>Gp", "", desc = "+Pull Request" },
      { "<leader>Gpc", "<cmd>GHClosePR<cr>", desc = "Close" },
      { "<leader>Gpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
      { "<leader>Gpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
      { "<leader>Gpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
      { "<leader>Gpp", "<cmd>GHPopOutPR<cr>", desc = "PopOut" },
      { "<leader>Gpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
      { "<leader>Gpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
      { "<leader>Gpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },
      { "<leader>Gr", "", desc = "+Review" },
      { "<leader>Grb", "<cmd>GHStartReview<cr>", desc = "Begin" },
      { "<leader>Grc", "<cmd>GHCloseReview<cr>", desc = "Close" },
      { "<leader>Grd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
      { "<leader>Gre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
      { "<leader>Grs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
      { "<leader>Grz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
      { "<leader>Gt", "", desc = "+Threads" },
      { "<leader>Gtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
      { "<leader>Gtn", "<cmd>GHNextThread<cr>", desc = "Next" },
      { "<leader>Gtt", "<cmd>GHToggleThread<cr>", desc = "Toggle" },
    },
  },
  {
    "folke/sidekick.nvim",
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>a"

          -- Normal mode mappings
          maps.n[prefix] = { desc = require("astroui").get_icon("Sidekick", 1, true) .. "Sidekick" }
          maps.n[prefix .. "a"] = {
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
          }
          maps.n[prefix .. "s"] = {
            function() require("sidekick.cli").select() end,
            desc = "Select CLI",
          }
          maps.n[prefix .. "d"] = {
            function() require("sidekick.cli").close() end,
            desc = "Detach a CLI Session",
          }
          maps.n[prefix .. "t"] = {
            function() require("sidekick.cli").send { msg = "{this}" } end,
            desc = "Send This",
          }
          maps.n[prefix .. "f"] = {
            function() require("sidekick.cli").send { msg = "{file}" } end,
            desc = "Send File",
          }
          maps.n[prefix .. "p"] = {
            function() require("sidekick.cli").prompt() end,
            desc = "Select Prompt",
          }

          maps.n[prefix .. "n"] = { desc = require("astroui").get_icon("SidekickBrain", 1, true) .. "NES" }
          maps.n[prefix .. "nt"] = {
            function() require("sidekick.nes").toggle() end,
            desc = "Toggle NES",
          }
          maps.n[prefix .. "ne"] = {
            function() require("sidekick.nes").enable() end,
            desc = "Enable NES",
          }
          maps.n[prefix .. "nd"] = {
            function() require("sidekick.nes").disable() end,
            desc = "Disable NES",
          }
          maps.n[prefix .. "nu"] = {
            function() require("sidekick.nes").update() end,
            desc = "Update Suggestions",
          }

          maps.n["<Tab>"] = {
            function()
              if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
          }
          maps.n["<C-.>"] = {
            function() require("sidekick.cli").toggle {} end,
            desc = "Sidekick Toggle",
          }

          -- Visual mode mappings
          maps.x[prefix] = { desc = require("astroui").get_icon("Sidekick", 1, true) .. "Sidekick" }
          maps.x[prefix .. "t"] = {
            function() require("sidekick.cli").send { msg = "{this}" } end,
            desc = "Send This",
          }
          maps.x[prefix .. "v"] = {
            function() require("sidekick.cli").send { msg = "{selection}" } end,
            desc = "Send Visual Selection",
          }
          maps.x[prefix .. "p"] = {
            function() require("sidekick.cli").prompt {} end,
            desc = "Select Prompt",
          }
          maps.x["<C-.>"] = {
            function() require("sidekick.cli").toggle {} end,
            desc = "Sidekick Toggle",
          }

          -- Insert mode mappings
          maps.i["<C-.>"] = {
            function() require("sidekick.cli").toggle {} end,
            desc = "Sidekick Toggle",
          }

          -- Terminal mode mappings
          maps.t["<C-.>"] = {
            function() require("sidekick.cli").toggle {} end,
            desc = "Sidekick Toggle",
          }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { Sidekick = "", SidekickBrain = "󰧑" } } },
    },
    opts = {
      nes = {
        enabled = true, -- If the user doesn't have the copilot LSP running internally this gets set as false
      },
      cli = {
        prompts = {
          generate_commit = "Generate commit with staged changes",
          create_branch_and_generate_commit = "Create branch and generate commit with staged changes",
          review_commit= "Can you review latest commit for any issues or improvements?",
          -- security = "Review {file} for security vulnerabilities",
          -- custom = function(ctx)
          --   return "Current file: " .. ctx.buf .. " at line " .. ctx.row
          -- end,
        },

        mux = {
          enabled = true,
        },
      },
    },
  },
  {
    'nvim-mini/mini.ai',
    opts = {
      custom_textobjects = {
        g = function(ai_type)
          local start_line, end_line = 1, vim.fn.line("$")
          if ai_type == "i" then
            -- Skip first and last blank lines for `i` textobject
            local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
            -- Do nothing for buffer with all blanks
            if first_nonblank == 0 or last_nonblank == 0 then
              return { from = { line = start_line, col = 1 } }
            end
            start_line, end_line = first_nonblank, last_nonblank
          end

          local to_col = math.max(vim.fn.getline(end_line):len(), 1)
          return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
        end
      }
    }
  },
  {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        -- add new user interface icon
        icons = {
          VimIcon = "",
          ScrollText = "",
          GitBranch = "",
          GitAdd = "",
          GitChange = "",
          GitDelete = "",
        },
        -- modify variables used by heirline but not defined in the setup call directly
        status = {
          -- define the separators between each section
          separators = {
            left = { "", "" }, -- separator for the left side of the statusline
            right = { " ", "" }, -- separator for the right side of the statusline
            tab = { "", "" },
          },
          -- add new colors that can be used by heirline
          colors = function(hl)
            local get_hlgroup = require("astroui").get_hlgroup
            -- use helper function to get highlight group properties
            local comment_fg = get_hlgroup("Comment").fg
            hl.git_branch_fg = comment_fg
            hl.git_added = comment_fg
            hl.git_changed = comment_fg
            hl.git_removed = comment_fg
            hl.blank_bg = get_hlgroup("Folded").fg
            hl.file_info_bg = get_hlgroup("Visual").bg
            hl.nav_icon_bg = get_hlgroup("String").fg
            hl.nav_fg = hl.nav_icon_bg
            hl.folder_icon_bg = get_hlgroup("Error").fg
            return hl
          end,
          attributes = {
            mode = { bold = true },
          },
          icon_highlights = {
            file_icon = {
              statusline = false,
            },
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astroui.status")
        opts.statusline = {
          -- default highlight for the entire statusline
          hl = { fg = "fg", bg = "bg" },
          -- each element following is a component in astroui.status module

          -- add the vim mode component
          status.component.mode({
            -- enable mode text with padding as well as an icon before it
            mode_text = {
              icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
            },
            -- surround the component with a separators
            surround = {
              -- it's a left element, so use the left separator
              separator = "left",
              -- set the color of the surrounding based on the current mode using astronvim.utils.status module
              color = function()
                return { main = status.hl.mode_bg(), right = "blank_bg" }
              end,
            },
          }),
          -- we want an empty space here so we can use the component builder to make a new section with just an empty string
          status.component.builder({
            { provider = "" },
            -- define the surrounding separator and colors to be used inside of the component
            -- and the color to the right of the separated out section
            surround = {
              separator = "left",
              color = { main = "blank_bg", right = "file_info_bg" },
            },
          }),
          -- add a section for the currently opened file information
          status.component.file_info({
            -- enable the file_icon and disable the highlighting based on filetype
            filename = { fallback = "Empty" },
            -- disable some of the info
            filetype = false,
            file_read_only = false,
            -- add padding
            padding = { right = 1 },
            -- define the section separator
            surround = { separator = "left", condition = false },
          }),
          -- add a component for the current git branch if it exists and use no separator for the sections
          status.component.git_branch({
            git_branch = { padding = { left = 1 } },
            surround = { separator = "none" },
          }),
          -- add a component for the current git diff if it exists and use no separator for the sections
          status.component.git_diff({
            padding = { left = 1 },
            surround = { separator = "none" },
          }),
          -- fill the rest of the statusline
          -- the elements after this will appear in the middle of the statusline
          status.component.fill(),
          -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
          status.component.lsp({
            lsp_client_names = false,
            surround = { separator = "none", color = "bg" },
          }),
          -- fill the rest of the statusline
          -- the elements after this will appear on the right of the statusline
          status.component.fill(),
          -- add a component for the current diagnostics if it exists and use the right separator for the section
          status.component.diagnostics({ surround = { separator = "right" } }),
          -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
          status.component.lsp({
            lsp_progress = false,
            surround = { separator = "right" },
          }),

          -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
          -- all of the children of this table will be treated together as a single component
          {
            -- define a simple component where the provider is just a folder icon
            status.component.builder({
              -- astronvim.get_icon gets the user interface icon for a closed folder with a space after it
              { provider = require("astroui").get_icon("FolderClosed") },
              -- add padding after icon
              padding = { right = 1 },
              -- set the foreground color to be used for the icon
              hl = { fg = "bg" },
              -- use the right separator and define the background color
              surround = { separator = "right", color = "folder_icon_bg" },
            }),
            -- add a file information component and only show the current working directory name
            status.component.file_info({
              -- we only want filename to be used and we can change the fname
              -- function to get the current working directory name
              filename = {
                fname = function(nr)
                  return vim.fn.getcwd(nr)
                end,
                padding = { left = 1 },
              },
              -- disable all other elements of the file_info component
              filetype = false,
              file_icon = false,
              file_modified = false,
              file_read_only = false,
              -- use no separator for this part but define a background color
              surround = {
                separator = "none",
                color = "file_info_bg",
                condition = false,
              },
            }),
          },

          -- the final component of the NvChad statusline is the navigation section
          -- this is very similar to the previous current working directory section with the icon
          { -- make nav section with icon border
            -- define a custom component with just a file icon
            status.component.builder({
              { provider = require("astroui").get_icon("ScrollText") },
              -- add padding after icon
              padding = { right = 1 },
              -- set the icon foreground
              hl = { fg = "bg" },
              -- use the right separator and define the background color
              -- as well as the color to the left of the separator
              surround = {
                separator = "right",
                color = { main = "nav_icon_bg", left = "file_info_bg" },
              },
            }),
            -- add a navigation component and just display the percentage of progress in the file
            status.component.nav({
              -- add some padding for the percentage provider
              percentage = { padding = { right = 1 } },
              -- disable all other providers
              ruler = false,
              scrollbar = false,
              -- use no separator and define the background color
              surround = { separator = "none", color = "file_info_bg" },
            }),
          },
          status.component.builder({
            {
              provider = function()
                local time = os.date("%H:%M") -- show hour and minute in 24 hour format
                ---@cast time string
                return status.utils.stylize(time, {
                  icon = { kind = "Clock", padding = { right = 1 } }, -- use our new clock icon
                  padding = { right = 1 }, -- pad the right side so it's not cramped
                })
              end,
            },
            update = { -- update should happen when the mode has changed as well as when the time has changed
              "User", -- We can use the User autocmd event space to tell the component when to update
              "ModeChanged",
              callback = vim.schedule_wrap(function(_, args)
                if -- update on user UpdateTime event and mode change
                  (args.event == "User" and args.match == "UpdateTime")
                  or (args.event == "ModeChanged" and args.match:match(".*:.*"))
                then
                  vim.cmd.redrawstatus() -- redraw on update
                end
              end),
            },
            hl = status.hl.get_attributes("mode"), -- highlight based on mode attributes
            surround = {
              separator = "right",
              color = function()
                return { main = status.hl.mode_bg(), left = "file_info_bg" }
              end,
            }, -- background highlight based on mode
          }),
        }
        -- Now that we have the component, we need a timer to emit the User UpdateTime event
        vim.uv.new_timer():start( -- timer for updating the time
          (60 - tonumber(os.date("%S"))) * 1000, -- offset timer based on current seconds past the minute
          60000, -- update every 60 seconds
          vim.schedule_wrap(function()
            vim.api.nvim_exec_autocmds( -- emit our new User event
              "User",
              { pattern = "UpdateTime", modeline = false }
            )
          end)
        )
      end,
    },
    {
      "chrisgrieser/nvim-various-textobjs",
      lazy = false,
      opts = {
        keymaps = {
          useDefaults = true,
          disabledDefaults = {
            "ag",
            "ig",
            "ao",
            "io"
          },
        }
      },
    }
  }
}
