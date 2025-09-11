return {
    -- DEPRECATING: ALL nvim-lspconfig CONFIG SHOULD BE TOGETHER TO WORK 
    -- LSP Configuration: Pyright for Python language server using nvim-lspconfig
    "neovim/nvim-lspconfig",
    config = function()
      -- Set up Pyright language server for Python
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
    end,
}
