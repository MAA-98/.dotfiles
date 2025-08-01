-- General editor options
require("config.settings")

-- Plugin manager bootstrap and setup
require("config.lazy")

-- Direct to use py venv which has pynvim and lang tools installed
vim.g.python3_host_prog = "/Users/marek/.python_venvs/nvim/bin/python"