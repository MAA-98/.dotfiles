--- Global Variables ---
vim.g.mapleader = " "             -- Space as leader key
vim.g.maplocalleader = "\\"
vim.g.netrw_liststyle = 3	        -- Open file explorer in tree view

--- Global Options ---
vim.opt.number = true               -- Show line numbers
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.shiftwidth = 2              -- Indent with 4 spaces
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true        -- for true color support
vim.opt.updatetime = 300            -- Faster completion experience
vim.opt.signcolumn = "yes"          -- Keep signcolumn visible
vim.opt.cursorline = true           -- Highlight current line

-- Code Folding Options 
vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldlevel = 99              -- Folds deeper than 99 levels folded by default
vim.opt.fillchars = vim.opt.fillchars + { fold = " " } -- Use spaces instead of dots for the rest of indent line
function _G.custom_fold_text()      -- Custom foldtext function
  local start_line = vim.v.foldstart
  local end_line = vim.v.foldend
  local line_count = end_line - start_line + 1

  -- Get indent of the start line (number of spaces at beginning)
  local line = vim.fn.getline(start_line)
  local indent = line:match("^%s*") or ""

  -- Length of indent in spaces
  local indent_len = #indent

  -- Length of the '~fold~' marker
  local fold_marker = "➤"
  local fold_marker_len = #fold_marker

  -- Calculate spaces to align fold info text at original indent, after the fold marker
  -- Ensure at least 1 space
  local spaces_after_marker = indent_len - fold_marker_len
  if spaces_after_marker < 1 then
    spaces_after_marker = 1
  end

  -- Compute indent level (number of indent steps, assuming tabstop=4)
  local indent_level = math.floor(#indent / vim.opt.shiftwidth)

  -- Assemble fold text: `~fold~   ...   Indent: ... | Lines: ...`
  local fold_text = fold_marker
    .. string.rep(" ", spaces_after_marker)
    .. "Indent: " .. indent_level .. " | Lines: " .. line_count

  return fold_text
end

vim.opt.foldtext = "v:lua.custom_fold_text()"           -- Set foldtext option to use this function
-- Note the color of highlights is adjusted in tokyonight cmd call

--- Diagnostic Options ---
vim.diagnostic.config({
  virtual_text = {    	          -- show errors/warnings inline
    prefix = "◀",		              -- a visible icon; alternatives: "●", "■", "▎"
    spacing = 2,
    severity = {
      min = vim.diagnostic.severity.WARN  -- show warnings and errors only
    },
  },
  signs = true,           	      -- show gutter signs
  update_in_insert = true,  	    -- update diagnostics while typing (optional)
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "Diag.:",
    prefix = "➤ ",
    focusable = true,
  },
})

--- Keybinds ---

-- Normal Mode Movement
vim.keymap.set('n', '<Esc>', 'i', { noremap = true, silent = true }) -- In normal mode, Esc goes to insertion mode
vim.keymap.set('n', '<Left>', 'b', { noremap = true, silent = true }) -- Arrow keys jump in normal mode
vim.keymap.set('n', '<Right>', 'e', { noremap = true, silent = true })
-- LSP keybinds
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true }) -- `leader,c,a` for code actions 
vim.keymap.set('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true }) -- `leader, g,d` goes to definitions
-- Buffer/Window Managements
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { noremap = true, silent = true }) -- `leader, b,d` deletes buffer
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { noremap = true, silent = true }) -- `leader q` quits buffer
vim.keymap.set('n', '<leader>wq', '<cmd>wq<CR>', { noremap = true, silent = true }) -- `leader w,q` saves and quits
vim.keymap.set('n', '<leader>wbd', '<cmd>w | bd<CR>', { noremap = true, silent = true }) -- leader, w, b, d writes and deletes buffer

--- LSPs ---
vim.env.PATH = vim.env.PATH .. ':/opt/homebrew/bin' 
vim.lsp.set_log_level("debug")    -- Optional, makes LSP logs verbose for debugging

vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--cross-file-rename",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_attach = function(client, bufnr)
    print("Attached to clangd LSP")
  end,
})

vim.lsp.config('pyright', {
  cmd = { "/opt/homebrew/bin/pyright-langserver", "--stdio" },
  filetypes = { 'python' },
  on_attach = function(client, bufnr)
    print("Attached to Pyright LS")
  end,
})
vim.lsp.config('hls', {
  cmd = { "/opt/homebrew/bin/haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell", "cabal" },  -- HLS common filetypes
  root_markers = { 'hie.yaml', 'stack.yaml', 'package.yaml.lock', '.git' },
  on_attach = function(client, bufnr)
    print("Attached to Haskell GHC LS")
  end,
})
vim.lsp.enable({ 'clangd', 'pyright', 'hls' })

-- Plugin manager setup, leader key(s) should be set beforehand
require("config.lazy")

--- System dark mode dependent theme, has to be after plugins loaded ---
local function is_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return (result:match("Dark") ~= nil)
end

local function set_macOS_theme()
  if is_dark_mode() then
    vim.cmd("colorscheme tokyonight-storm") -- use tokyonight storm variant
  else
    vim.cmd("colorscheme tokyonight-day")   -- light variant
  end

  -- Remove or soften fold highlight after colorscheme loads
  vim.cmd("highlight Folded guibg=NONE gui=bold,italic,underline cterm=NONE guisp=NONE")
end

set_macOS_theme() -- Call the function after plugins have loaded
vim.api.nvim_create_user_command("ReloadTheme", set_macOS_theme, {}) -- Command for refreshing theme

-- Direct to use py venv which has pynvim and lang tools installed
vim.g.python3_host_prog = "/Users/marek/.python_venvs/nvim/bin/python"
