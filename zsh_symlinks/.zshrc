# ~/.zshrc
# Interactive shell entry point.
# Loads modular config files from ~/.config/zsh/

[[ -o interactive ]] || return

# Load config files in numeric order.
# The (N) glob qualifier means "no error if nothing matches".
for file in "$HOME/.config/zsh"/[0-9][0-9]-*.zsh(N); do
  source "$file"
done
