#!/bin/zsh
#
# Bootstrap shell config using GNU Stow.
# - removes conflicting old zsh config paths
# - applies the zsh_symlinks package
# - creates ~/.my_secrets with restricted permissions
# - restarts the shell

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow is not installed. Install it first (e.g. brew install stow)."
  exit 1
fi

cd "$DOTFILES_DIR"

# Remove old direct files/symlinks so Stow can replace them cleanly.
echo "Removing conflicting existing paths..."
rm -f "$HOME/.zshrc"
rm -f "$HOME/.zprofile"

# Remove the old whole-.config symlink if it exists from the previous setup.
# Do not remove ~/.config if it is a real directory.
if [[ -L "$HOME/.config" ]]; then
  rm "$HOME/.config"
fi

# Remove any previous conflicting config so Stow can recreate it.
rm -rf "$HOME/.config/zsh"
rm -rf "$HOME/.config/alacritty"
rm -rf "$HOME/.config/gh"
rm -rf "$HOME/.config/nvim"

# Apply packages from the repo root.
STOW_PACKAGES=(zsh_symlinks alacritty gh nvim)

echo "Applying stow packages: ${STOW_PACKAGES[*]}"
stow -t "$HOME" --restow "${STOW_PACKAGES[@]}"

echo "Finished applying stow packages."

# Create ~/.my_secrets if missing and lock permissions down.
SECRETS_FILE="$HOME/.my_secrets"

if [[ ! -e "$SECRETS_FILE" ]]; then
  echo "Creating empty $SECRETS_FILE"
  touch "$SECRETS_FILE"
  chmod 600 "$SECRETS_FILE"
else
  echo "$SECRETS_FILE already exists, skipping creation."
fi

echo "Restarting your shell to apply changes..."
exec zsh -l
