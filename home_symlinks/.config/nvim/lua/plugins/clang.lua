return {
  {
    -- LSP Configuration: clangd for C and C++ language server using nvim-lspconfig
    "neovim/nvim-lspconfig",
    config = function()
      -- Set up clangd lang server for C and C++
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
    end,
  },
}
