# ~/.zshrc
#
# This file is sourced by the Z shell (zsh) each time an interactive shell session starts.
# It configures the shell environment for interactive use:
#   aliases, functions, and keybindings.
# It is NOT sourced by login shells by default; for login shells, ~/.zprofile or ~/.zlogin are used.
#
# Note:
# - Changes to this file take effect in new shell sessions or after running `source ~/.zshrc` in an existing shell.

# echos filename (if in interactive shell, for some safety if called from non-interactive context)
[[ $- == *i* ]] && echo "[🎉 .zshrc sourced]"

# --- FUNCTIONS ---

mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

# --- ZSH PLUGINS ---

# Tab completion (usually not needed on Macs)
# autoload -Uz compinit
# compinit

# Path for zsh plugins
ZSH_PLUGIN_DIR="$HOME/dotfiles/plugins"

# Function to clone if missing
source_or_clone_plugin() {
  local repo_url=$1
  local plugin_dir_path=$2
  local plugin_filepath=$3
  
  if [[ ! -f "$plugin_filepath" ]]; then
    if [ -d "$plugin_dir_path" ]; then
      echo "[🧹 Removing incomplete plugin dir...]"
      rm -rf "$plugin_dir_path"
    fi
    echo "[⏳ Cloning plugin from $repo_url to $plugin_dir_path]"
    git clone --depth=1 "$repo_url" "$plugin_dir_path"
  fi
  # Source if present
  if [[ -f "$plugin_filepath" ]]; then
    source "$plugin_filepath"
  else
    echo "[⚠️  zsh-autosuggestions plugin missing]"
  fi
}

# zsh-autosuggestions plugin:
ZSH_AUTOSUGGESTIONS_URL="https://github.com/zsh-users/zsh-autosuggestions.git"
ZSH_AUTOSUGGESTIONS_DIR="$ZSH_PLUGIN_DIR/zsh-autosuggestions"
ZSH_AUTOSUGGESTIONS_FILE="$ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh"

source_or_clone_plugin "$ZSH_AUTOSUGGESTIONS_URL" "$ZSH_AUTOSUGGESTIONS_DIR" "$ZSH_AUTOSUGGESTIONS_FILE"

# zsh-syntax-highlighting plugin: ---- MUST BE SOURCED LAST apparently
ZSH_SYNTAX_HIGHLIGHTING_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"
ZSH_SYNTAX_HIGHLIGHTING_DIR="$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
ZSH_SYNTAX_HIGHLIGHTING_FILE="$ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh"

source_or_clone_plugin "$ZSH_SYNTAX_HIGHLIGHTING_URL" "$ZSH_SYNTAX_HIGHLIGHTING_DIR" "$ZSH_SYNTAX_HIGHLIGHTING_FILE"

