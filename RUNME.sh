#!/bin/bash

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
elif [[ "$ARCH" == "x86_64" ]]; then
  HOMEBREW_PREFIX="/usr/local"
fi

if ! command -v brew &>/dev/null
then
  echo "Homebrew is not installed. Downloading and installing Homebrew..."

  curl -sLo "$TEMP_DIR/homebrew.json" https://api.github.com/repos/Homebrew/brew/releases/latest

  HOMEBREW_PKG_URL=$(grep -o '"browser_download_url":\s\?"[^"]*pkg' "$TEMP_DIR/homebrew.json" | grep -o '[^"]*$')

  curl -sLo "$TEMP_DIR/homebrew.pkg" "$HOMEBREW_PKG_URL"

  sudo installer -pkg "$TEMP_DIR/homebrew.pkg" -target /

  eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
fi

MIN_VERSION='3.12.2'
CUR_VERSION=$(python3 --version | awk '{print $2}')
VERSIONS=$(printf "%s\n%s" "$MIN_VERSION" "$CUR_VERSION")
PKG="python-$MIN_VERSION-macos11.pkg"
PKG_URL="https://www.python.org/ftp/python/$MIN_VERSION/$PKG"

if ! sort --check=silent --version-sort <<< "$VERSIONS"
then
  echo "Currently installed Python is $CUR_VERSION. Downloading and installing Python $MIN_VERSION..."
  curl -sLo "$PKG" "$PKG_URL"
  sudo installer -pkg "$PKG" -target /
  rm "$PKG"
  bash -c "/Applications/Python*/Install\ Certificates.command"
  alias python3='/usr/local/bin/python3'
fi

TEMP_DIR=$(mktemp -d)
python3 -m venv "$TEMP_DIR"
. "$TEMP_DIR/bin/activate"

if [[ $(type -t python3) = 'alias' ]];
then
  unalias python3
fi

python3 -m pip install --quiet --upgrade pip
python3 -m pip install --quiet ansible-core

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yaml --ask-become-pass --verbose

rm -rf "$TEMP_DIR"
