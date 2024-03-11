# Set default locale to ensure commands like tr work as expected.
LC_CTYPE=C

# Include beginning timestamp and duration in history file.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Do not write to the history file if the command is a duplicate of the previous command.
setopt HIST_IGNORE_DUPS

eval "$(/opt/homebrew/bin/brew shellenv)"
