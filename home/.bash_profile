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
