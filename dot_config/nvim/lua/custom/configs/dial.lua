local status_ok, dial = pcall(require, "dial.config")
if not status_ok then
  return
end

local augend = require "dial.augend"
dial.augends:register_group {
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.semver.alias.semver,
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
}
