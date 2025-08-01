# ~/.zprofile
#
# This file is read by Z shell (zsh) at the start of a login shell session.
# It sets up the login shell environment, typically environment variables and
# path settings required before interactive or non-interactive shells launch.
#
# On macOS, this is a good place to set up Homebrew environment settings so that
# commands installed by Homebrew are available right away.
#
# Note:
# - This file is NOT sourced by non-login interactive shells.
# - Changes here take effect in new login shell sessions or after running `source ~/.zprofile`.
#

# echos filename (if in interactive shell, for some safety if called from non-interactive context)
[[ $- == *i* ]] && echo "[🎉 .zprofile sourced]"

# Check if the home directory has the .my_secrets dot file and run contents if so
test -f "$HOME/.my_secrets" && source "$HOME/.my_secrets" && [[ $- == *i* ]] && echo "[🎉 .my_secrets sourced]"

# Updates your environment variables so that you can use Homebrew-installed tools and packages
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- PATHS ---
# Created by `pipx` on 2025-07-23 19:44:10
export PATH="$PATH:/Users/marek/.local/bin"
# Created by LLVM: brew install llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

