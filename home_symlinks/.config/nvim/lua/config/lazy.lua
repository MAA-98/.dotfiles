-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Import general/common plugins that load normally (not lazy-loaded by filetype)
    { import = "plugins.general" },

    -- Lazy-load the python-specific plugins module on python files or commands
    { 
       import = "plugins.python",
      -- Load only when a Python file is opened (lazy load)
      ft = "python",
      -- optionally also trigger on commands if you want
      -- cmd = { "PyrightOrganizeImports", "Black" },
    },
    -- Same for C/C++ and clang
    {
      import = "plugins.clang",
      ft = { "c", "cpp", "h", "hpp" }, -- load on C/C++ filetypes
    },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
