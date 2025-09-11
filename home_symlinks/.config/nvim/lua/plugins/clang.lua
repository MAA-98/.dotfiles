return {
  {
    -- LSP Configuration: clangd, pyright, dartls
    "neovim/nvim-lspconfig",
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
          -- Enable semantic tokens if supported
--          if client.server_capabilities.semanticTokensProvider then
--            vim.lsp.semantic_tokens.start(bufnr)
--          end
          print("Attached to clangd LSP")
        end,
      })

      -- Set up Pyright LS for Python
      require("lspconfig").pyright.setup({
        cmd = { "/opt/homebrew/bin/pyright-langserver", "--stdio"},
       -- settings = {
       --   python = {
       --     analysis = {
       --       semanticHighlighting = true,
       --     },
       --   },
       -- },
        on_attach = function(client, bufnr)
          -- Enable semantic tokens if supported
--          if client.server_capabilities.semanticTokensProvider then
--            vim.lsp.semantic_tokens.start(bufnr)
--          end
          print("Attached to Pyright LSP")
        end,
      })

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
}
