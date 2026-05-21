# Vi-style line editing
bindkey -v
export KEYTIMEOUT=1 # More responsive keymap switching

# Cursor shape:
# - insert mode: bar cursor
# - command mode: block cursor
zle-keymap-select() {
  case $KEYMAP in
    vicmd)
      printf '\e[2 q'   # steady block
      ;;
    viins|main)
      printf '\e[6 q'   # steady bar
      ;;
  esac
}

zle-line-init() {
  printf '\e[6 q'       # start in insert mode with bar cursor
}

zle-line-finish() {
  printf '\e[2 q'       # restore block cursor when leaving the prompt
}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

# Update theme colors on opening interactive shell in Alacritty window
if [[ -n "$ALACRITTY_WINDOW_ID" ]]; then
  ~/.local/bin/alacritty-theme
fi