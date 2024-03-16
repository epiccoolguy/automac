# shellcheck shell=bash
# shellcheck disable=SC1091

# Source ~/.bashrc if running interactive.
case "$-" in *i*) if [ -r "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi;; esac

# BEGIN Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# END Load Homebrew

# BEGIN Load venv
if [ -f "$HOME/.python/venv/bin/activate" ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  . "$HOME/.python/venv/bin/activate"
fi
# END Load venv

# BEGIN Load Rust
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
# END Load Rust

# BEGIN asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi
# END asdf
