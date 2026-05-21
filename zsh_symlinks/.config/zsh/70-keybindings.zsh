# Copy last N completed tmux command blocks to macOS clipboard
# Usage in vicmd:
#   gy   -> last 1 block
#   2gy  -> last 2 blocks
#   3gy  -> last 3 blocks
tmux_copy_last_blocks() {
  emulate -L zsh
  setopt localoptions pipefail

  if [[ -z "$TMUX" ]]; then
    zle -M "Not inside tmux"
    return 1
  fi

  local n=${NUMERIC:-1}
  if (( n < 1 )); then
    n=1
  fi

  # Matches lines like:
  #   ~/Desktop/project ❯ cd infra/terraform
  #   ~/Desktop/project/infra/terraform ❯
  local prompt_re='^.*[[:space:]]❯([[:space:]]+.*)?$'

  if tmux capture-pane -pJ -S - | awk -v n="$n" -v re="$prompt_re" '
    { lines[NR] = $0; if ($0 ~ re) prompts[++pc] = NR }
    END {
      # Need n completed blocks, which means n+1 prompt markers
      if (pc < n + 1) exit 2

      start = prompts[pc - n]
      end   = prompts[pc] - 1

      if (start < 1 || end < start) exit 3

      for (i = start; i <= end; i++) print lines[i]
    }
  ' | pbcopy; then
    zle -M "Copied last $n command block(s)"
  else
    zle -M "No completed command blocks found"
    return 1
  fi
}

zle -N tmux_copy_last_blocks
bindkey -M vicmd 'gy' tmux_copy_last_blocks

# Clear screen
zle_clear_screen() {
  zle clear-screen
}
zle -N zle_clear_screen

# Clear tmux history, then refresh the screen
zle_tmux_clear_history() {
  zle -I
  if [[ -n "$TMUX" ]]; then
    tmux clear-history
  fi
  zle clear-screen
}
zle -N zle_tmux_clear_history

# Bind in vi command mode
bindkey -M vicmd 'zs' zle_clear_screen
bindkey -M vicmd 'zh' zle_tmux_clear_history

# History search based on current command prefix
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Arrow keys in vi insert mode: prefix-based history search
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search

# Arrow keys in insert mode: character movement
bindkey -M viins '^[[D' backward-char
bindkey -M viins '^[[C' forward-char

# Arrow keys in command mode: word movement
bindkey -M vicmd '^[[D' backward-word
bindkey -M vicmd '^[[C' forward-word