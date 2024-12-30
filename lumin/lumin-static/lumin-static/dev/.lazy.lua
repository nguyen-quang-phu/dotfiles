local severities = {
  warning = vim.diagnostic.severity.WARN,
  error = vim.diagnostic.severity.ERROR,
}

local stylelint = {
  cmd = function()
    local local_stylelint = vim.fn.fnamemodify(
      "/Users/dev/Code/keynold/linters/lumin/lumin-static/stylelint/node_modules/.bin/stylelint",
      ":p"
    )
    local stat = vim.loop.fs_stat(local_stylelint)
    if stat then
      return local_stylelint
    end
    return "stylelint"
  end,
  stdin = true,
  args = {
    "-f",
    "json",
    "-c",
    "/Users/dev/Code/keynold/linters/lumin/lumin-static/stylelint/stylelint.config.mjs",
    "--stdin",
    "--stdin-filename",
    function()
      return vim.fn.expand("%:p")
    end,
  },
  stream = "both",
  ignore_exitcode = true,
  parser = function(output)
    local status, decoded = pcall(vim.json.decode, output)
    if status then
      decoded = decoded[1]
    else
      decoded = {
        warnings = {
          {
            line = 1,
            column = 1,
            text = "Stylelint error, run `stylelint " .. vim.fn.expand("%") .. "` for more info.",
            severity = "error",
            rule = "none",
          },
        },
        errored = true,
      }
    end
    local diagnostics = {}
    for _, message in ipairs(decoded.warnings) do
      table.insert(diagnostics, {
        lnum = message.line - 1,
        col = message.column - 1,
        end_lnum = message.line - 1,
        end_col = message.column - 1,
        message = message.text,
        code = message.rule,
        user_data = {
          lsp = {
            code = message.rule,
          },
        },
        severity = severities[message.severity],
        source = "stylelint",
      })
    end
    return diagnostics
  end,
}

return {
  {
    "folke/lazy.nvim",
    opts = {
      spec = {
        {
          import = "lazyvim.plugins.extras.lang.typescript",
        },
        {
          import = "lazyvim.plugins.extras.lang.json",
        }
      },
    }
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          enabled = true,
        },
        eslint = {
          mason = false,
          cmd ={
            "vscode-eslint-language-server",
            "--stdio",
          },
          settings = {
            nodePath = "/Users/dev/Code/keynold/linters/lumin/lumin-static/eslint/node_modules",
            options = {
              overrideConfigFile = "/Users/dev/Code/keynold/linters/lumin/lumin-static/eslint/eslint.config.mjs",
            }
          }
        },
        cssls = {
          enabled = true,
        },
        somesass_ls = {
          enabled = true,
          settings = {
            somesass = {
              workspace = {
                exclude = { "node_modules" },
                -- loadPaths = {
                --   "node_modules/@lumin-ui/dist/design-tokens/koala/scss/"
                -- }
              },
            },
          },
        },
        css_variables = {
          settings = {
            cssVariables = {
              lookupFiles = {
                '**/*.less',
                '**/*.scss',
                '**/*.sass',
                '**/*.css',
                'node_modules/@lumin-ui/dist/design-tokens/kiwi/css/borderRadius.css',
                'node_modules/@lumin-ui/dist/design-tokens/kiwi/css/spacings.css',
                'node_modules/@lumin-ui/dist/design-tokens/kiwi/css/themes.css',
              },
            },
          },
        },
        -- stylelint_lsp = {
        --   mason = false,
        --   filetypes = { "scss" },
        --   settings = {
        --     stylelintplus = {
        --       configFile = "/Users/dev/Code/keynold/linters/lumin/lumin-static/stylelint/stylelint.config.mjs",
        --       -- config = "/Users/dev/Code/keynold/linters/lumin/lumin-static/stylelint/node_modules",
        --     }
        --   }
        -- }
      }
    }
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        scss = { "stylelint" },
      },
      linters = {
        stylelint = stylelint,
      }
    }
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        scss = { "stylelint"},
      },
      formatters = {
        stylelint = {
          command = "/Users/dev/Code/keynold/linters/lumin/lumin-static/stylelint/node_modules/.bin/stylelint",
          args = {
            "-c",
            "/Users/dev/Code/keynold/linters/lumin/lumin-static/stylelint/stylelint.config.mjs",
            "--stdin",
            "--stdin-filename",
            "$FILENAME",
            "--fix",
          },
          exit_codes = { 0, 2 }, -- code 2 is given when trying file includees some non-autofixable errors
          stdin = true,
        }
      }
    }
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>ff", function()
        require("snacks").picker.files({
          exclude = {
            "tmp",
            "bin",
            "jest",
            "types",
            "coverage",
            "node_modules",
            ".cache",
            "gengo",
            -- "public",
            "static-font-icomoon",
          },
        })
      end, desc = "Find Files (Root Dir)" },
      { "<leader>fw", function()
        require("snacks").picker.grep({
          regex = false,
          args = {
            "--glob=!coverage/**",
            "--glob=!node_modules/**",
            "--glob=!dist/**",
            "--glob=!build/**",
            "--glob=!gengo/**",
            "--glob=!types/**",
            "--glob=!.cache/**",
            "--glob=!.slicemachine/**",
            "--glob=!__tests__/**",
            "--glob=!__mocks__/**",
            "--glob=!static-font-icomoon/**",
            "--glob=!customtypes/**",
            "--glob=!public/**",
            "--glob=!.gemini/**",
            "--glob=!pnpm-lock.yaml",
          },
        })
      end, desc = "Find Files (Root Dir)" },
    },
    opts = {
    }
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npx jest",
            jestArguments = function(defaultArguments, context)
              return defaultArguments
            end,
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
            isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          }),
        }
      })
    end
  }
}
