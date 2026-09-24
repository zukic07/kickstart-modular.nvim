return {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    require('nvim-dap-virtual-text').setup {
      commented = true, -- zeigt Werte als Kommentar an
      enabled = true,
    }
  end,
}
