#! /bin/sh

TEMP_DIR=$(mktemp -d)
python3 -m venv "$TEMP_DIR"
. "$TEMP_DIR/bin/activate"

python3 -m pip install --quiet --upgrade pip
python3 -m pip install --quiet ansible-core

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yaml --ask-become-pass --verbose
