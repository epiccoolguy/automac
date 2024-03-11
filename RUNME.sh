#! /bin/sh

export PATH="$(python3 -c 'import os,sysconfig;print(sysconfig.get_path("scripts",f"{os.name}_user"))'):$PATH"

python3 -m pip install --upgrade --user pip
python3 -m pip install --user ansible-core

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yaml
