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

  -- Python LSP, loaded on Python files:
  {
    "neovim/nvim-lspconfig",
    ft = "python",
    config = function()
      -- Set up Pyright LS for Python
      require("lspconfig").pyright.setup({
        cmd = { "/opt/homebrew/bin/pyright-langserver", "--stdio"},
        on_attach = function(client, bufnr)
          print("Attached to Pyright LSP")
        end,
      })
    end,
  },
  -- C/C++ LSP, loaded on C/C++ files:
  {
    "neovim/nvim-lspconfig",
    ft = { "c", "cpp", "h", "hpp" },        -- load on C/C++ filetypes
    config = function()
      -- Set up clangd LS for C and C++
      require("lspconfig").clangd.setup({
        cmd = {
            "clangd",
            "--background-index",           -- enable background indexing for faster queries
            "--clang-tidy",                 -- enable clang-tidy style linting
            "--completion-style=detailed",  -- detailed completion items including signatures
            "--cross-file-rename",          -- enable cross file rename support
        },
        init_options = {
            clangdFileStatus = true,       -- display file status in the status bar
            usePlaceholders = true,        -- insert argument placeholders in completion
            completeUnimported = true,     -- complete symbols that haven't been #included yet
            semanticHighlighting = true,   -- enable semantic highlighting
        },
        on_attach = function(client, bufnr)
          print("Attached to clangd LSP")
        end,
      })
    end,
  },
  -- Dart LSP, loaded on Dart files:
  {
    "neovim/nvim-lspconfig",
    ft = "dart",
    config = function()
      -- Set up Dart LS for Dart
      require("lspconfig").dartls.setup({
        filetypes = { "dart" },
        root_dir = require("lspconfig.util").root_pattern("pubspec.yaml", ".git"),
        on_attach = function(client, bufnr)
          print("Attached to Dart LSP")
        end,
      })
    end,
  },


  -- automatically check for plugin updates
  checker = { enabled = true },
})
