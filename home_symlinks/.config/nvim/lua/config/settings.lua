-- Basic settings
vim.g.mapleader = " "             -- Space as leader key
vim.o.number = true               -- Show line numbers
vim.o.expandtab = true            -- Use spaces instead of tabs
vim.o.shiftwidth = 4              -- Indent with 4 spaces
vim.o.tabstop = 4
vim.o.smartindent = true
vim.o.termguicolors = true        -- for true color support
vim.o.updatetime = 300            -- Faster completion experience
vim.o.signcolumn = "yes"          -- Keep signcolumn visible
vim.o.cursorline = true           -- Highlight current line
vim.diagnostic.config({
  virtual_text = {    	          -- show errors/warnings inline
    prefix = "◀",		          -- a visible icon; alternatives: "●", "■", "▎"
    spacing = 6,
    severity = {
      min = vim.diagnostic.severity.WARN  -- show warnings and errors only
    },
  },
  signs = true,           	      -- show gutter signs
  update_in_insert = true,  	  -- update diagnostics while typing (optional)
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "Diagnostics:",
    prefix = "➤ ",
    focusable = true,
  },
})
vim.g.netrw_liststyle = 3	      -- Open file explorer in tree view

-- Some leader key shortcuts
vim.api.nvim_set_keymap('n', '<Esc>', 'i', { noremap = true, silent = true })       -- In normal mode, Esc goes to insertion mode
