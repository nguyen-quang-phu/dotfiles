# Personal Org-mode Workflow & Reference Guide

This document serves as a central reference for your Neovim Org-mode setup, covering keybindings, scheduling logic, and best practices for habit tracking.

---

## 1. Keybindings & Conflicts

### Copilot vs. Orgmode Tab Conflict
The `<Tab>` key is used by both GitHub Copilot (to accept suggestions) and Orgmode (to cycle visibility). To prioritize Copilot, the `org_cycle` mapping is disabled in your configuration.

- **Current Status**: `<Tab>` is reserved for Copilot.
- **How to Cycle Visibility**: Use your custom mappings or the command line if needed.
- **Config Location**: `dot_config/nvim/lua/plugins/orgmode.lua` under `mappings.org`.

### Custom Leader Mappings
- `<leader>o`: Orgmode Menu
- `<leader>oi`: Orgmode Insert Menu

---

## 2. Scheduling & Repeater Logic

The choice of repeater determines how tasks behave when you miss a day.

| Syntax | Name | Behavior if you miss a day | Best for... |
| :--- | :--- | :--- | :--- |
| `+1d` | **Cumulative** | Task stays on the missed date. You must "catch up" on every day. | Medications, daily logs. |
| `++1d` | **Jump** | Task "jumps" to the next valid date (today or tomorrow). Skips missed days. | **Habits (Gym, Reading).** |
| `.+1d` | **Restart** | Schedules the next one exactly X days after you *actually* finished it. | Changing filters, hair cuts. |

---

## 3. Managing Workdays vs. Weekends

To have a task (like "Review PR") appear **only on weekdays** without creating duplicate entries:

### Recommended Setup:
Use a single headline with five separate timestamps. This skips Saturday/Sunday entirely.

```org
* TODO Review PR
  SCHEDULED: <2026-06-08 Mon ++1w>
  SCHEDULED: <2026-06-09 Tue ++1w>
  SCHEDULED: <2026-06-10 Wed ++1w>
  SCHEDULED: <2026-06-11 Thu ++1w>
  SCHEDULED: <2026-06-12 Fri ++1w>
```

---

## 4. Alternative Time Slots (Habits)

If a habit can be done at different times (e.g., Morning OR Evening), use **Properties** to keep the headline clean.

### Best Practice Example:
```org
* TODO Workout 15 minutes
  SCHEDULED: <2026-06-08 Mon 07:00 ++1d>
  :PROPERTIES:
  :STYLE: habit
  :TIME_MORNING: 07:00 - 07:30
  :TIME_EVENING: 17:00 - 17:30
  :END:
```
- **Workflow**: Schedule for the **earliest** time. If you miss it, the task remains in the agenda until you finish it in the evening slot.

---

## 5. Org Super Agenda vs. Native Agenda

There is a technical difference in how these two interfaces handle completion:

- **Native Agenda (`<leader>oa`)**: Full support for repeaters. Marking a task `DONE` shifts the date forward automatically.
- **Org Super Agenda**: Faster grouping and filtering, but may not always trigger the complex date-shifting logic of `nvim-orgmode` for repeating tasks.
- **Tip**: If a date doesn't shift correctly in Super Agenda, use `cs` to manually reschedule or use the Native Agenda for that specific action.

---

## 6. Official Resources
- [nvim-orgmode Documentation](https://github.com/nvim-orgmode/orgmode/tree/master/docs)
- [Org-mode Manual (Official)](https://orgmode.org/manual/index.html)
- [Org-super-agenda (Neovim Port)](https://github.com/hamidi-dev/org-super-agenda.nvim)
