return {
  "mfussenegger/nvim-dap",
  config = function(_, opts)
    local dap = require "dap"
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "~/vscode-php-debug/out/phpDebug.js" },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}",
        },
      },
    }
  end,
  dependencies = { "suketa/nvim-dap-ruby", config = true },
}
