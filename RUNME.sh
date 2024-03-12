#! /bin/sh

PYTHON_PATH=$(python3 -c 'import os,sysconfig;print(sysconfig.get_path("scripts",f"{os.name}_user"))')
PATH="$PYTHON_PATH:$PATH"
export PATH

python3 -m pip install --quiet --upgrade --user pip
python3 -m pip install --quiet --user ansible-core

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yaml
