# Make and change to a directory in one command
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

# Change to a directory and list its contents
cdls() {
  cd -- "$1" && ls -GA
}

# Touch paste
# Create a file and fill it with the current macOS clipboard contents
# Usage:
#   tchp FILE
tchp() {
  emulate -L zsh

  if (( $# == 0 )); then
    print -u2 "usage: tchp FILE"
    return 1
  fi

  local file=$1
  touch -- "$file" && pbpaste >| "$file"
}
