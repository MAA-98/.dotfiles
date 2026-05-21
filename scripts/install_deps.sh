#!/bin/zsh
#
# Install required dependencies using Homebrew + Brewfile.

set -euo pipefail

SCRIPT_DIR="${0:A:h}"
REPO_ROOT="${SCRIPT_DIR:h}"
BREWFILE="$REPO_ROOT/Brewfile"

if [[ ! -f "$BREWFILE" ]]; then
  echo "Brewfile not found at: $BREWFILE"
  exit 1
fi

# Install Homebrew if missing
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Load brew into this shell
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "Homebrew was not found after installation."
  exit 1
fi

echo "Updating Homebrew..."
brew update

echo "Installing dependencies from Brewfile..."
brew bundle install --file "$BREWFILE"

echo "Cleaning up..."
brew cleanup

echo "Done."
