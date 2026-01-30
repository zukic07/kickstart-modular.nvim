-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/home/ahz/nvim-workspaces-root/' .. project_name
--                                               ^^
--                                               string concattenation in Lua
local bundles = {
  -- Path to java-debug-adapter jar file
  vim.fn.glob('/home/ahz/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/*.jar', true),
}
-- See `:help vim.lsp.start` for an overview of the supported `config` options.
local config = {
  name = 'jdtls',

  -- `cmd` defines the executable to launch eclipse.jdt.ls.
  -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
  --
  -- As alternative you could also avoid the `jdtls` wrapper and launch
  -- eclipse.jdt.ls via the `java` executable
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = { 'jdtls', '-data', workspace_dir },

  -- `root_dir` must point to the root of your project.
  -- See `:help vim.fs.root`
  root_dir = vim.fs.root(0, { 'gradlew', '.git' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      format = {
        enabled = false, -- Hier den Formatter komplett abschalten
      },
    },
  },

  -- This sets the `initializationOptions` sent to the language server
  -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
  -- you'll need to set the `bundles`
  --
  -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
  },
}
require('jdtls').start_or_attach(config)

-- Custom configs
-- start jdtls explicitly in a folder
vim.api.nvim_create_user_command('JdtlsTemp', function(opts)
  local root = opts.args ~= '' and opts.args or vim.fn.getcwd()
  local workspace = vim.fn.stdpath 'cache' .. '/jdtls-temp'

  require('jdtls').start_or_attach {
    cmd = {
      'jdtls',
      '-data',
      workspace,
    },
    root_dir = root,
  }

  print('jdtls TEMP gestartet für: ' .. root)
end, {
  nargs = '?',
  complete = 'dir',
})

-- Add new Command

-- Organize all imports
local function organize_imports_all_java()
  local java_files = vim.fn.glob('**/*.java', true, true)

  for _, file in ipairs(java_files) do
    -- Buffer anlegen ohne ihn anzuzeigen
    local bufnr = vim.fn.bufadd(file)

    -- Swapfile deaktivieren
    vim.bo[bufnr].swapfile = false

    -- Buffer laden
    vim.fn.bufload(bufnr)

    -- Warten bis LSP attached ist
    vim.wait(1000, function()
      return next(vim.lsp.get_active_clients { bufnr = bufnr }) ~= nil
    end)

    -- Organize Imports
    vim.lsp.buf.execute_command {
      command = 'java.edit.organizeImports',
      arguments = { vim.uri_from_bufnr(bufnr) },
    }

    -- speichern
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd 'silent write'
    end)

    -- optional: Buffer wieder entladen
    vim.cmd('silent bwipeout ' .. bufnr)
  end

  print '✔ Organize imports abgeschlossen (swap-sicher)'
end

vim.api.nvim_create_user_command('JavaOrganizeImportsAll', organize_imports_all_java, {})
