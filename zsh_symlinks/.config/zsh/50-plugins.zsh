# Plugin root directory
ZSH_PLUGIN_DIR="$HOME/.dotfiles/zsh_plugins"

# Source a plugin if present; clone it first if missing.
source_or_clone_plugin() {
  local repo_url=$1
  local plugin_dir_path=$2
  local plugin_filepath=$3

  if [[ ! -f "$plugin_filepath" ]]; then
    if [[ -d "$plugin_dir_path" ]]; then
      echo "[🧹 Removing incomplete plugin dir...]"
      rm -rf "$plugin_dir_path"
    fi
    echo "[⏳ Cloning plugin from $repo_url to $plugin_dir_path]"
    git clone --depth=1 "$repo_url" "$plugin_dir_path"
  fi

  if [[ -f "$plugin_filepath" ]]; then
    source "$plugin_filepath"
  else
    echo "[⚠️  plugin missing: $plugin_filepath]"
  fi
}

# zsh-autosuggestions
ZSH_AUTOSUGGESTIONS_URL="https://github.com/zsh-users/zsh-autosuggestions.git"
ZSH_AUTOSUGGESTIONS_DIR="$ZSH_PLUGIN_DIR/zsh-autosuggestions"
ZSH_AUTOSUGGESTIONS_FILE="$ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh"
source_or_clone_plugin "$ZSH_AUTOSUGGESTIONS_URL" "$ZSH_AUTOSUGGESTIONS_DIR" "$ZSH_AUTOSUGGESTIONS_FILE"

# zsh-syntax-highlighting
# Must be sourced after most other shell setup.
ZSH_SYNTAX_HIGHLIGHTING_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"
ZSH_SYNTAX_HIGHLIGHTING_DIR="$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
ZSH_SYNTAX_HIGHLIGHTING_FILE="$ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh"
source_or_clone_plugin "$ZSH_SYNTAX_HIGHLIGHTING_URL" "$ZSH_SYNTAX_HIGHLIGHTING_DIR" "$ZSH_SYNTAX_HIGHLIGHTING_FILE"
