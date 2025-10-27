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

require('lazy').setup({
  -- Import general/common plugins that load normally (not lazy-loaded by filetype)
  { import = "plugins.general" },

  {
    "nvim-flutter/flutter-tools.nvim",
    ft = { "dart" },  -- Load only when opening Dart files
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",  -- optional for better UI
    },
    config = function()
      require("flutter-tools").setup({
      })
    end,
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
