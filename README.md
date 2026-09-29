# bhushan

Simple Python environment manager — like conda / pyenv-virtualenv, no conda needed.

## Install
```bash
curl -fsSL https://raw.githubusercontent.com/bhushanpatil2702/bhushan/main/install.sh | bash
source ~/.bashrc
```

## Usage
```bash
bhushan pythons                  # Python versions on this machine
bhushan create myapp -p 3.12     # create env
bhushan activate myapp           # activate
bhushan install requests flask   # install packages
bhushan packages                 # list packages
bhushan list                     # list envs
bhushan deactivate               # deactivate
bhushan remove myapp             # delete env
bhushan help                     # all commands
```

## Uninstall
```bash
curl -fsSL https://raw.githubusercontent.com/bhushanpatil2702/bhushan/main/install.sh | bash -s -- --uninstall
```
