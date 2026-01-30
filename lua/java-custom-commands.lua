-- Custom JDTLS configs
-- start jdtls explicitly in a folder, but before opening a Java file
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

-- Extend workspace with Jars
local function add_jar(jar)
  jar = vim.fn.fnamemodify(jar, ':p')

  local config = vim.lsp.get_active_clients({
    name = 'jdtls',
  })[1].config

  config.settings = config.settings or {}
  config.settings.java = config.settings.java or {}
  config.settings.java.project = config.settings.java.project or {}

  local libs = config.settings.java.project.referencedLibraries or {}

  table.insert(libs, jar)
  config.settings.java.project.referencedLibraries = libs

  vim.lsp.buf_notify(0, 'workspace/didChangeConfiguration', {
    settings = config.settings,
  })

  print('JAR hinzugefügt: ' .. jar)
end

-- Add new Command
vim.api.nvim_create_user_command('AddJar', function(opts)
  add_jar(opts.args)
end, {
  nargs = 1,
  complete = 'file',
})
