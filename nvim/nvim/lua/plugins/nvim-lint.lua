local severity_map = {
  ["fatal"] = vim.diagnostic.severity.ERROR,
  ["error"] = vim.diagnostic.severity.ERROR,
  ["warning"] = vim.diagnostic.severity.WARN,
  ["convention"] = vim.diagnostic.severity.HINT,
  ["refactor"] = vim.diagnostic.severity.INFO,
  ["info"] = vim.diagnostic.severity.INFO,
}

return {
  "mfussenegger/nvim-lint",
  enabled = true,
  opts = {
    linters_by_ft = {
      nix = { "statix", "deadnix" },
      lua = { "luacheck" },
      markdown = { "markdownlint-cli2" },
      ruby = { "rubocop", "reek" },
      -- go = { "golangcilint" },
      proto = { "buf-lint" },
      eruby = { "erb_lint" },
      slim = { "slimlint" },
      dockerfile = { "hadolint" },
      -- javascript = { "eslint" },
      -- javascriptreact = { "eslint" },
      -- typescript = { "eslint" },
      -- typescriptreact = { "eslint" },
      -- vue = { "eslint" },
    },
    linters = {
      golangcilint = {
        cmd = "golangci-lint",
        append_fname = false,
        args = {
          "run",
          "--output.json.path=stdout",
          function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end,
        },
        stream = "stdout",
        parser = function(output, bufnr, cwd)
          if output == "" then
            return {}
          end
          local decoded = vim.json.decode(output)
          if decoded["Issues"] == nil or type(decoded["Issues"]) == "userdata" then
            return {}
          end

          local diagnostics = {}
          for _, item in ipairs(decoded["Issues"]) do
            local curfile = vim.api.nvim_buf_get_name(bufnr)
            local curfile_abs = vim.fn.fnamemodify(curfile, ":p")
            local curfile_norm = vim.fs.normalize(curfile_abs)

            local lintedfile = cwd .. "/" .. item.Pos.Filename
            local lintedfile_abs = vim.fn.fnamemodify(lintedfile, ":p")
            local lintedfile_norm = vim.fs.normalize(lintedfile_abs)

            if curfile_norm == lintedfile_norm then
              -- only publish if those are the current file diagnostics
              local sv = severities[item.Severity] or severities.warning
              table.insert(diagnostics, {
                lnum = item.Pos.Line > 0 and item.Pos.Line - 1 or 0,
                col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0,
                end_lnum = item.Pos.Line > 0 and item.Pos.Line - 1 or 0,
                end_col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0,
                severity = sv,
                source = item.FromLinter,
                message = item.Text,
              })
            end
          end
          return diagnostics
        end,
      },
      rubocop = {
        stdin = false,
        cmd = "bundle",
        args = {
          "exec",
          "rubocop",
          "--format",
          "json",
          "--force-exclusion",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local decoded = vim.json.decode(output)

          if not decoded.files[1] then
            return diagnostics
          end

          local offences = decoded.files[1].offenses

          for _, off in pairs(offences) do
            table.insert(diagnostics, {
              source = "rubocop",
              lnum = off.location.start_line - 1,
              col = off.location.start_column - 1,
              end_lnum = off.location.last_line - 1,
              end_col = off.location.last_column,
              severity = severity_map[off.severity],
              message = off.message,
              code = off.cop_name,
            })
          end

          return diagnostics
        end,
      },
      reek = {
        cmd = "bundle",
        args = {
          "exec",
          "reek",
          "--format",
          "json",
          "--force-exclusion",
        },
        append_fname = true,
        stream = "stdout",
        stdin = false,
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local offences = vim.json.decode(output)

          for _, off in pairs(offences) do
            local col = string.len(vim.api.nvim_buf_get_lines(0, off.lines[1] - 1, off.lines[1], true)[1])
            table.insert(diagnostics, {
              source = "[reek]",
              lnum = off.lines[1] - 1,
              end_lnum = off.lines[1] - 1,
              col = col,
              end_col = col,
              severity = severity_map["warning"],
              message = off.message,
              code = off.smell_type,
            })
          end

          return diagnostics
        end,
      },
      slimlint = {
        cmd = "bundle",
        args = {
          "exec",
          "slim-lint",
          "--reporter",
          "json",
        },
        ignore_exitcode = true,
        append_fname = true,
        stream = "stdout",
        stdin = false,
        parser = function(output)
          local diagnostics = {}
          local decoded = vim.json.decode(output)

          if not decoded.files[1] then
            return diagnostics
          end

          local offences = decoded.files[1].offenses

          for _, off in pairs(offences) do
            local col = string.len(vim.api.nvim_buf_get_lines(0, off.location.line - 1, off.location.line, true)[1])
            table.insert(diagnostics, {
              source = "slim-lint",
              lnum = off.location.line - 1,
              end_lnum = off.location.line - 1,
              col = col + 1,
              end_col = col + 1,
              severity = severity_map[off.severity],
              message = off.message,
              code = off.linter,
            })
          end

          return diagnostics
        end,
        --   local diagnostics = {}
        --   local decoded = vim.json.decode(output)
        --
        --   if not decoded.files[1] then
        --     return diagnostics
        --   end
        --
        --   local offences = decoded.files[1].offenses
        --
        --   for _, off in pairs(offences) do
        --     table.insert(diagnostics, {
        --       source = "custom slim lint",
        --       lnum = off.location.start_line - 1,
        --       col = off.location.start_column - 1,
        --       end_lnum = off.location.last_line - 1,
        --       end_col = off.location.last_column,
        --       severity = severity_map[off.severity],
        --       message = off.message,
        --       code = off.cop_name,
        --     })
        --   end
        --
        --   return diagnostics
        -- end,
      },
    },
  },
}
