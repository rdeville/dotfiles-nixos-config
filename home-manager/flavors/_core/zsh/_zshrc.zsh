# ls colors
autoload -U colors && colors

export PATH="$HOME/.local/share/bin:$HOME/.local/bin:$PATH"

autoload -Uz compinit

() {
  # Ensure ~/.zcompdump is at least 16 hours old before rebuilding it
  local outdated=("$1"(Nch+16))
  if [[ -f $1 ]] && (( $#outdated == 0 )); then
    compinit -C
    return
  fi

  rm -f "$1" "${1}.zwc"
  compinit
  zcompile "$1"
} "$ZDOTDIR/.zcompdump"

if [[ -f "${HOME}/.zshrc.local" ]]; then
  source ~/.zshrc.local
fi

if command -v fastfetch >/dev/null 2>&1 &&
  [[ -z "${VIRTUAL_ENV}" ]] &&
  [[ -z "${VIMRUNTIME}" ]]; then
  fastfetch
fi
