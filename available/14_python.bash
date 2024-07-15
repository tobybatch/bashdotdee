if [ -e "$HOME"/.pyenv/bin/pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
export PYTHONPYCACHEPREFIX=/tmp
