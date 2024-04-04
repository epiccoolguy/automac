# automac

Automatically set up a Mac using Ansible.

## Run

Manually sign into the App Store before running the following script.

1. Sign into the App Store
2. Install command line developer tools: `xcode-select --install`
3. Clone this repository: `https://github.com/epiccoolguy/automac.git`
4. Run the script: `./RUNME.sh`
   Or override variables from `vars.yaml`: `./RUNME.sh --extra-vars "git_user_name='Miguel Lo-A-Foe'  git_user_email='miguel@loafoe.dev'"`
