local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  return
end

lspsaga.setup {
  debug = true,
  finder = {
    max_height = 0.6,
    keys = {
      vsplit = 'v',
      edit = '<cr>'
    }
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
}
