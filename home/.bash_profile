# Source ~/.bashrc if running interactive.
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

# BEGIN Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# END Load Homebrew

# BEGIN Load venv
if [ -f "$HOME/.python/venv/bin/activate" ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  . "$HOME/.python/venv/bin/activate"
fi
# END Load venv
