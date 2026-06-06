return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		dependencies = {
			{ "danilshvalov/org-modern.nvim", lazy = true },
		},
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/org/**/*",
				org_agenda_show_future_repeats = false,
				org_agenda_span = 10,
				org_agenda_start_day = "-1d",
				org_agenda_start_on_weekday = false,
				org_default_notes_file = "~/org/refile.org",
  			org_todo_keywords = {
    			{  'TODO(t)', 'PROJ(p)', 'STRT(s)', 'WAIT(w)', 'HOLD(h)', 'IDEA(i)', 'LOOP(r)', '|', 'DONE(d)', 'KILL(k)','Fail(f)' },
  			},
				ui = {
					input = {
      			use_vim_ui = true
    			},
					menu = {
						handler = function(data)
							require("org-modern.menu")
								:new({
									window = { margin = { 1, 0, 1, 0 }, padding = { 0, 1, 0, 1 }, title_pos = "center", border = "rounded", zindex = 1000 },
									icons = {
										separator = "➜",
									},
								})
								:open(data)
						end,
					},
				},
			})
			-- Experimental LSP support
			vim.lsp.enable("org")
		end,
	}
}
