-- Basic settings
vim.g.mapleader = " "             -- Space as leader key
vim.g.maplocalleader = "\\"
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
    spacing = 4,
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
vim.g.netrw_liststyle = 3	        -- Open file explorer in tree view

--- Code folding ---
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
  local indent_level = math.floor(#indent / vim.o.shiftwidth)

  -- Assemble fold text: `~fold~   ...   Indent: ... | Lines: ...`
  local fold_text = fold_marker
    .. string.rep(" ", spaces_after_marker)
    .. "Indent: " .. indent_level .. " | Lines: " .. line_count

  return fold_text
end

vim.opt.foldtext = "v:lua.custom_fold_text()"           -- Set foldtext option to use this function
-- Color of highlights is adjusted in tokyonight cmd call

--- Keybinds ---
vim.api.nvim_set_keymap('n', '<Esc>', 'i', { noremap = true, silent = true }) -- In normal mode, Esc goes to insertion mode
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true }) -- `leader,c,a` for code actions from LSP
vim.keymap.set('n', '<Left>', 'b', { noremap = true, silent = true }) -- Arrow keys jump in normal mode
vim.keymap.set('n', '<Right>', 'e', { noremap = true, silent = true })
