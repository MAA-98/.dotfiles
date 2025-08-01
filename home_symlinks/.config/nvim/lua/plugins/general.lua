return {
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },

  -- Core autocompletion framework: nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- LSP source for nvim-cmp (completions from language servers)
      "hrsh7th/cmp-nvim-lsp",
      -- Buffer words source (fuzzy text completion from open buffers)
      "hrsh7th/cmp-buffer",
      -- File system path completions
      "hrsh7th/cmp-path",
      -- Snippet engine
      "L3MON4D3/LuaSnip",
      -- Snippet completions source for nvim-cmp
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          -- Required to expand snippets with luasnip
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Scroll docs up/down with Ctrl-d/f
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Trigger completion menu with Ctrl-Space
          ["<C-Space>"] = cmp.mapping.complete(),
          -- Confirm selection with Enter
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Tab and Shift-Tab to navigate completion items and snippets
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- Sources for completions
        sources = {
          { name = "nvim_lsp" },  -- language server completions
          { name = "luasnip" },   -- snippet completions
          { name = "buffer" },    -- buffer words completions
          { name = "path" },      -- filesystem path completions
        },
      })
    end,
  },

  -- Treesitter for enhanced syntax highlighting and indentation
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- Automatically install and update parsers on install
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "json", "toml", "bash", "lua", "python", "cpp" },   -- Languages to install parsers for
        highlight = { enable = true },                 -- Enable syntax highlighting
        indent = { enable = true },                    -- Enable treesitter-based indentation
      })
    end,
  },

  -- Git gutter signs showing added/removed/changed lines in sign column
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
}
