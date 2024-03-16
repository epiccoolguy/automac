# shellcheck shell=bash

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
