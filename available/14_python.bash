if [ -e "$HOME"/.pyenv/bin/pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  echo Set pyenv to "$PYENV_ROOT" / "$PYENV_VERSION"
fi
