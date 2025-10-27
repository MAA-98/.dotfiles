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

  -- Mason for lazy loading LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "clangd" }, -- servers you want installed
        automatic_installation = true,
      })
    end,
  },
  
  -- LSP Server
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require('lspconfig')

      vim.env.PATH = vim.env.PATH .. ':/opt/homebrew/bin' -- make sure this is before configs
    
    lspconfig.clangd.setup({
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

    --[[
      -- Configure servers with new native API
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

      vim.env.PATH = vim.env.PATH .. ':/opt/homebrew/bin'    -- Important so Neovim can find hls
      vim.lsp.set_log_level("debug")    -- Optional, makes LSP logs verbose for debugging

    --]]
    end,
  },
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
