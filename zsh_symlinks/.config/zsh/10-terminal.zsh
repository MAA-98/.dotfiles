# 10-terminal.zsh
# Terminal/presentation-related shell setup.

# Prompt
PROMPT='%F{yellow}%~%f %F{cyan}❯%f '
RPROMPT=''

# If we're in Alacritty, update theme/colors on startup
if [[ -n "$ALACRITTY_WINDOW_ID" ]]; then
  command -v alacritty-theme >/dev/null 2>&1 && alacritty-theme
fi