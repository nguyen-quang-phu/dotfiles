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
				org_agenda_skip_scheduled_if_done = true,
				org_agenda_span = 10,
				org_agenda_start_day = "+0d",
				org_agenda_start_on_weekday = false,
				org_default_notes_file = "~/org/refile.org",
				org_log_done = "time",
				org_log_into_drawer = "LOGBOOK",
				org_startup_folded= "showeverything",
  			org_todo_keywords = {
  				{
						'TODO(t)',
						'IN_PROGRESS(i)',
						'SPENDING(s)',
						'|',
						'DONE(d)',
						'FAIL(f)',
					},
				},
				org_agenda_time_grid = {
					times = {
						400,
						500,
						800,
						900,
						1000,
						1200,
						1400,
						1600,
						1800,
						2000,
						2030,
						2100,
						2130,
						2200,
						2230,
						2300,
					}
				},
  			mappings = {
  				org = {
						org_toggle_checkbox = false,
  					org_cycle = false,
  				}
  			},
				-- ui = {
				-- 	input = {
				--   			use_vim_ui = true
				-- 			},
				-- 	menu = {
				-- 		handler = function(data)
				-- 			require("org-modern.menu")
				-- 				:new({
				-- 					window = { margin = { 1, 0, 1, 0 }, padding = { 0, 1, 0, 1 }, title_pos = "center", border = "rounded", zindex = 1000 },
				-- 					icons = {
				-- 						separator = "➜",
				-- 					},
				-- 				})
				-- 				:open(data)
				-- 		end,
				-- 	},
				-- },
				notifications = {
    			enabled = true,
    			cron_enabled = true,
    			repeater_reminder_time = false,
    			deadline_warning_reminder_time = false,
    			reminder_time = 10,
    			deadline_reminder = true,
    			scheduled_reminder = true,
    			notifier = function(tasks)
      			local result = {}
      			for _, task in ipairs(tasks) do
        			require('orgmode.utils').concat(result, {
          			string.format('# %s (%s)', task.category, task.humanized_duration),
          			string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
          			string.format('%s: <%s>', task.type, task.time:to_string())
        			})
      			end

      			if not vim.tbl_isempty(result) then
        			require('orgmode.notifications.notification_popup'):new({ content = result })
        			-- Example: if you use Snacks, you can do something like this (THis is not implemented)
        			require("snacks").notifier.notify(table.concat(result, '\n'), vim.log.levels.INFO, {
          			title = 'Orgmode',
          			ft = 'org'
        			})
      			end
    			end,
    			cron_notifier = function(tasks)
      			for _, task in ipairs(tasks) do
        			local title = string.format('%s (%s)', task.category, task.humanized_duration)
        			local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
        			local date = string.format('%s: %s', task.type, task.time:to_string())

        			-- Linux
        			if vim.fn.executable('notify-send') == 1 then
          			vim.system({
            			'notify-send',
            			'--icon=/path/to/orgmode/assets/nvim-orgmode-small.png',
            			'--app-name=orgmode',
            			title,
            			string.format('%s\n%s', subtitle, date),
          			})
        			end

        			-- MacOS
        			if vim.fn.executable('terminal-notifier') == 1 then
          			vim.system({ 'terminal-notifier', '-title', title, '-subtitle', subtitle, '-message', date })
        			end
      			end
    			end
  			},
			})
			-- Experimental LSP support
			vim.lsp.enable("org")
		end,
	}
}
