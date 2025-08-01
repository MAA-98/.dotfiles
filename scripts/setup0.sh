#!/bin/zsh
#
# Script for setting up home config files:
# - symlinks `.zshrc` and `.zprofile` to home directory.
# - creates ~/.my_secrets file and restricts permissions
# - restarts shell, running .zsh config files

set -e # Exit on error

DOTFILES_DEST="$HOME/.dotfiles/home_symlinks/"

echo "Creating symlinks from /home_symlinks to home."
# Array of config files to symlink, for now just:
files=(.zshrc .zprofile)

for file in "${files[@]}"; do
  target="$DOTFILES_DEST/$file"
  link="$HOME/$file"

  # Check if a file or link already exists at the link location
  if [ -e "$link" ] || [ -L "$link" ]; then
	echo "Found existing $link"
	TIMESTAMP=$(date +%Y%m%d_%H%M%S)
	backup_link="${link}.bak.$TIMESTAMP"
    echo "Backing up existing $link to $backup_link"
    mv "$link" "$backup_link"
  fi

  # Create symbolic link
  echo "Creating symlink: $link -> $target"
  ln -s "$target" "$link"
done

echo "Finished creating symlinks."

# Add .my_secrets file and chmod 600
SECRETS_FILE="$HOME/.my_secrets"

if [ ! -e "$SECRETS_FILE" ]; then
  echo "Creating empty $SECRETS_FILE"
  touch "$SECRETS_FILE"
  chmod 600 "$SECRETS_FILE"
else
  echo "$SECRETS_FILE already exists, skipping creation."
fi

echo "Restarting your shell to apply changes..."
exec $SHELL -l
