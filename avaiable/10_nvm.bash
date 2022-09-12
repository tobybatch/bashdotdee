if [ -z "$NVM_V" ]; then
  export NVM_V=14.15.3
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ ! -d "${HOME}/.nvm/versions/node/v${NVM_V}" ]; then
  nvm install ${NVM_V}
fi

nvm use $NVM_V
