return {
  { "nvim-lua/plenary.nvim" },
  {"brandoncc/git-worktree.nvim",
    branch = "catch-and-handle-telescope-related-error",
    config = function(_, opts)
      local Worktree = require("git-worktree")
      Worktree.setup(opts)

      local Job = require("plenary.job")

      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          -- local pane_name = utils.shorten(metadata.path, 20, true)
          local pane_name = "test_pane_name"

          local function toggle_zellij_floating_window()
            Job:new({
              command = "zellij",
              args = {
                "action",
                "toggle-floating-panes",
              },
            }):start()
          end

          local function rename_zellij_pane()
            Job:new({
              command = "zellij",
              args = {
                "action",
                "rename-pane",
                pane_name,
              },
              on_exit = toggle_zellij_floating_window,
            }):start()
          end

          local function new_zellij_floating_pane()
            Job:new({
              command = "zellij",
              args = {
                "run",
                "-f",
                "--",
                "fish",
              },
              on_exit = rename_zellij_pane,
            }):start()
          end

          new_zellij_floating_pane()
        end
      end)
    end,
  },
}
