# Source ~/.bashrc if running interactive.
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# BEGIN Load venv
if [ -f "$HOME/.python/venv/bin/activate" ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  . "$HOME/.python/venv/bin/activate"
fi
# END Load venv
