# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source ~/.bashrc if running interactive.
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
