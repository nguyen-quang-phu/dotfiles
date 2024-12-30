return {
  'yelog/i18n.nvim',
  enabled = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('i18n').setup({
    })
  end
}
