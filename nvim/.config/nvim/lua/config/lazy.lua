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

-- Specs table: add other plugin or import entries here
local specs = {
  { import = "plugins.general" },

--[[ Not using Flutter these days
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
--]]
}

-- Checking plugin specs are not nil or malformed, gives detailed error msg
for i, spec in ipairs(specs) do
  if type(spec) == "table" and not (spec[1] or spec.name or spec.import) then
    error(("plugin spec #%d is missing a repo/import"):format(i))
  elseif type(spec) ~= "table" and type(spec) ~= "string" then
    error(("plugin spec #%d has invalid type %s"):format(i, type(spec)))
  end
end

-- require with options table adding checker
require("lazy").setup(specs, {
  checker = { enabled = true },
  -- other options go here
})

