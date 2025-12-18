-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', '<Cmd>Neotree toggle<CR>', desc = 'NeoTree toggle' },
  },
  opts = {
    filesystem = { window = { mappings = {
      ['\\'] = 'close_window',
      ['<space>'] = 'none',
    } } },
    git_status = { window = { mappings = {
      ['\\'] = 'close_window',
      ['<space>'] = 'none',
    } } },
    buffers = { window = { mappings = {
      ['\\'] = 'close_window',
      ['<space>'] = 'none',
    } } },
  },
}
