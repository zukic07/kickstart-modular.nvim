-- [[ IBM z/OS High Level Assembler (HLASM) Plugin Settings ]]

-- Basic buffer options for IBM Assembler
vim.opt_local.iskeyword:append { '@', '#', '$' }
vim.opt_local.commentstring = '* %s'
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 8

-- Standard HLASM Columns (Spalte 10: Opcode, Spalte 16: Operanden, Spalte 72: Continuation)
vim.opt_local.colorcolumn = '10,16,72'
