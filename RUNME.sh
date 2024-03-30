#!/bin/bash

EXPECTED_PYTHON_VERSION='3.12.2'
EXPECTED_ANSIBLE_VERSION='2.16.4'

check_version() {
  MIN_VERSION=$1
  CUR_VERSION=$2
  VERSIONS=$(printf "%s\n%s" "$MIN_VERSION" "$CUR_VERSION")

  if ! sort --check=silent --version-sort <<< "$VERSIONS"
  then
    return 1
  fi

  return 0
}

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

if ! command -v brew &>/dev/null
then
  echo "Homebrew is not installed. Downloading and installing Homebrew..."

  curl -sLo "$TEMP_DIR/homebrew.json" https://api.github.com/repos/Homebrew/brew/releases/latest

  HOMEBREW_PKG_URL=$(grep -o '"browser_download_url":\s\?"[^"]*pkg' "$TEMP_DIR/homebrew.json" | grep -o '[^"]*$')

  curl -sLo "$TEMP_DIR/homebrew.pkg" "$HOMEBREW_PKG_URL"

  sudo installer -pkg "$TEMP_DIR/homebrew.pkg" -target /

  ARCH=$(uname -m)
  if [[ "$ARCH" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  elif [[ "$ARCH" == "x86_64" ]]; then
    HOMEBREW_PREFIX="/usr/local"
  fi

  eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
fi

CURRENT_PYTHON_VERSION=$(python3 --version | awk '{print $2}')

if ! check_version "$EXPECTED_PYTHON_VERSION" "$CURRENT_PYTHON_VERSION"
then
  echo "Currently installed Python is below expected version $EXPECTED_PYTHON_VERSION. Downloading and installing the latest Python..."

  brew install python
fi

CURRENT_ANSIBLE_VERSION=$(ansible --version | sed -n 's/.*core \([^]]*\)].*/\1/p')

if ! check_version "$EXPECTED_ANSIBLE_VERSION" "$CURRENT_ANSIBLE_VERSION"
then
  echo "Currently installed Ansible is below expected version $EXPECTED_ANSIBLE_VERSION. Downloading and installing the latest Ansible..."

  brew install ansible
fi

hash -r 2> /dev/null

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yaml --ask-become-pass
