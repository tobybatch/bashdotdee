export PATH=$PATH:/home/tobias/opt/pycharm-2020.1.2/bin
# if command -v pyenv 1>/dev/null 2>&1; then
export PYENV_VERSION=3.8.8
if [ -e $HOME/.pyenv/bin/pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  echo Set pyenv to $PYENV_ROOT / $PYENV_VERSION
fi
