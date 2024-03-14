# Shell prompt
PROMPT="%{$fg[red]%}%n@%m %{$fg[blue]%}%~ %{$reset_color%}%% "

# Set default locale to ensure commands like tr work as expected.
LC_CTYPE=C

# Include beginning timestamp in history file.
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
# Append to history file instead of overwriting.
shopt -s histappend
# Immediately append to the history file on command instead of on exit.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Do not write to the history file if the command is a duplicate of the previous command.
HISTCONTROL=ignoredups
# Load last million lines
HISTSIZE=1000000
# Keep all history
unset HISTFILESIZE

# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
