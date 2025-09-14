-- General editor options and keybinds
require("config.settings")

-- Plugin manager setup, leader key(s) should be set beforehand
require("config.lazy")

-- Set theme dynamically according to dark mode, has to be after plugins loaded
local function is_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return (result:match("Dark") ~= nil)
end

local function set_macOS_theme()
  if is_dark_mode() then
    vim.cmd("colorscheme tokyonight-storm") -- use tokyonight storm variant
  else
    vim.cmd("colorscheme tokyonight-day")   -- light variant
  end

  -- Remove or soften fold highlight after colorscheme loads
  vim.cmd("highlight Folded guibg=NONE gui=bold,italic,underline cterm=NONE guisp=NONE")
end

-- Call the function after plugins have loaded
set_macOS_theme()
-- Command for refreshing theme
vim.api.nvim_create_user_command("ReloadTheme", set_macOS_theme, {})

-- Direct to use py venv which has pynvim and lang tools installed
vim.g.python3_host_prog = "/Users/marek/.python_venvs/nvim/bin/python"
