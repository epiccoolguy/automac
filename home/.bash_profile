# shellcheck shell=bash
# shellcheck disable=SC1091

# Source ~/.bashrc if running interactive.
case "$-" in *i*) if [ -r "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi;; esac

# BEGIN Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# END Load Homebrew

# BEGIN asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi
# END asdf

# BEGIN fzf
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type file"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"
export FZF_DEFAULT_OPTS=""
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'bat --color=always {}'"
# END fzf
