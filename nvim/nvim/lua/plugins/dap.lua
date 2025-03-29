return {
  {
    {
      "mfussenegger/nvim-dap",
      optional = true,
      dependencies = {
        {
          "suketa/nvim-dap-ruby",
          config = function()
            require("dap-ruby").setup()
          end,
        },
      },
      opts = function()
        local dap = require("dap")
        -- if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              LazyVim.get_pkg_path("js-debug-adapter", "js-debug/src/dapDebugServer.js"),
              "${port}",
            },
          },
        }
        require("dap").adapters["chrome"] = {
          type = "executable",
          command = "node",
          args = {
            LazyVim.get_pkg_path("chrome-debug-adapter", "out/src/chromeDebug.js"),
          },
        }

        -- end
        if not dap.adapters["node"] then
          dap.adapters["node"] = function(cb, config)
            if config.type == "node" then
              config.type = "pwa-node"
            end
            local nativeAdapter = dap.adapters["pwa-node"]
            if type(nativeAdapter) == "function" then
              nativeAdapter(cb, config)
            else
              cb(nativeAdapter)
            end
          end
        end

        local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

        local vscode = require("dap.ext.vscode")
        vscode.type_to_filetypes["node"] = js_filetypes
        vscode.type_to_filetypes["pwa-node"] = js_filetypes

        for _, language in ipairs(js_filetypes) do
          -- if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
          -- end
        end

        dap.configurations.javascriptreact = { -- change this to javascript if needed
          {
            name = "Next.js: debug full stack",
            type = "node",
            request = "launch",
            program = "${workspaceFolder}/node_modules/.bin/next",
            runtimeArgs = { "--inspect" },
            cwd = "${workspaceFolder}/src",
            skipFiles = { "<node_internals>/**" },
            serverReadyAction = {
              action = "debugWithEdge",
              killOnServerStop = true,
              pattern = "- Local:.+(https?://.+)",
              uriFormat = "%s",
              webRoot = "${workspaceFolder}",
            },
          },
          {
            name = "chrome",
            type = "chrome",
            request = "attach",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}",
          },
        }

        dap.configurations.typescriptreact = { -- change to typescript if needed
          {
            name = "Next.js: debug full stack",
            type = "node",
            request = "launch",
            program = "${workspaceFolder}/node_modules/.bin/next",
            runtimeArgs = { "--inspect" },
            cwd = "${workspaceFolder}/src",
            skipFiles = { "<node_internals>/**" },
            preLaunchTask = "tsc: build - tsconfig.json",
            outFiles = { "${workspaceFolder}/out/**/*.js" },
            serverReadyAction = {
              action = "debugWithEdge",
              killOnServerStop = true,
              pattern = "- Local:.+(https?://.+)",
              uriFormat = "%s",
              webRoot = "${workspaceFolder}",
            },
          },
          {
            name = "chrome",
            type = "chrome",
            request = "attach",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}",
          },
        }
      end,
    },
  },
}
