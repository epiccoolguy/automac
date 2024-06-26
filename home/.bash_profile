# shellcheck shell=bash
# shellcheck disable=SC1091,SC1090

# Source ~/.bashrc if it exists
if [ -r "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi

# Set XDG Configuration Directory
export XDG_CONFIG_HOME="$HOME/.config"

# BEGIN Load Homebrew
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$ARCH" == "x86_64" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
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

# BEGIN gcloud
export CLOUDSDK_PYTHON=python3
if [ -f "$HOME/.gcloud/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/.gcloud/google-cloud-sdk/path.bash.inc"; fi
if [ -f "$HOME/.gcloud/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/.gcloud/google-cloud-sdk/completion.bash.inc"; fi
# END gcloud

# BEGIN bash-completion@2
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi
# END bash-completion@2

# BEGIN vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# END vscode
