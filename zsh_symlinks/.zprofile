# ~/.zprofile
#
# Login-shell environment setup.
# Put environment variables and PATH additions here.
# Keep interactive-only config in ~/.zshrc.

# Load secrets if present.
# This file is expected to contain shell-compatible exports.
if [[ -r "$HOME/.my_secrets" ]]; then
  source "$HOME/.my_secrets"
fi

# Homebrew environment.
# Makes Homebrew-installed tools available in login shells.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Machine-specific PATH setup.
computer_name=$(scutil --get ComputerName 2>/dev/null || true)

case "$computer_name" in
  MacBookAir0)
    # Add local user binaries.
    path=("$HOME/.local/bin" $path)

    # LLVM from Homebrew.
    path=(/opt/homebrew/opt/llvm/bin $path)
    ;;
esac

# Keep PATH synchronized if anything modified the zsh path array.
export PATH
