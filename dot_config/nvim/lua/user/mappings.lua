-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>lrct"] = {
      function()
        require("tmux-awesome-manager").switch_open_as()
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<leader>b"] = { name = "Buffers" },
    ["<leader>e"] = { "<cmd>Neotree focus<cr>" },
    ["<leader>ld"] = { ":call AddDebugger()<CR>" },
    ["<leader>lD"] = { ":call ClearDebugger()<CR>" },
    -- ["<leader>b"] = { "<cmd>Neotree toggle<cr>" },
    ["<S-D-f>"] = { "<cmd>Telescope live_grep hidden=true no_ignore=true<cr>" },
    ["<D-f>"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr><cmd> w <CR>" },
    ["<D-p>"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>" },
    ["<leader>la"] = { "<Cmd>Lspsaga code_action<Cr>" },
    ["gd"] = { "<Cmd>Lspsaga goto_definition<CR>" },
    ["gr"] = { "<Plug>ReplaceWithRegisterOperator" },
    ["grr"] = { "<Plug>ReplaceWithRegisterLine" },
    ["<leader>a"] = { "<cmd>AerialToggle<CR>" },
    ["gS"] = { "<cmd>SplitjoinSplit<CR><cr>" },
    ["gJ"] = { "<cmd>SplitjoinJoin<CR><cr>" },
    ["<C-g>"] = { "<cmd>let @+=expand('%:p')<cr>" },
    ["<leader>lrr"] = { "<cmd>lua require('ror.commands').list_commands()<CR>" },
    [",l"] = { "<cmd>lua require('chainsaw').variableLog()<CR>" },
    [",d"] = { "<cmd>lua require('chainsaw').removeLogs()<CR>" },
    [",L"] = { "<cmd>lua require('chainsaw').messageLog()<CR>" },
    ["<leader>oo"] = { "<cmd>:Other<CR>" },
    ["<leader>os"] = { "<cmd>:OtherSplit<CR>" },
    ["<leader>ov"] = { "<cmd>:OtherVSplit<CR>" },
    ["<leader>ot"] = { "<cmd>:OtherTabNew<CR>" },
    ["<leader>oc"] = { "<cmd>:OtherClear<CR>" },

    -- quick sav
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  i = {
    ["<D-v>"] = { "<c-r>+" },
  },
  c = {
    ["<D-v>"] = { "<c-r>+" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["gr"] = { "<Plug>ReplaceWithRegisterVisual", desc = "ReplaceWithRegisterVisual" },
  },
}
