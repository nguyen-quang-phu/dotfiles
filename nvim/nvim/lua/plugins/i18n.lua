return {
  'yelog/i18n.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('i18n').setup({
    })
  end
}
