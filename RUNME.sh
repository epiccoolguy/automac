#!/bin/bash

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
  alias python3='/usr/local/bin/python3'
fi

TEMP_DIR=$(mktemp -d)
python3 -m venv "$TEMP_DIR"
. "$TEMP_DIR/bin/activate"

python3 -m pip install --quiet --upgrade pip
python3 -m pip install --quiet ansible-core

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yaml --ask-become-pass --verbose
