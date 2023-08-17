if [ -z "$NVM_V" ]; then
  export NVM_V=18.14.1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ ! -d "${HOME}/.nvm/versions/node/v${NVM_V}" ]; then
  nvm install ${NVM_V}
fi

export PATH=$PATH:/home/tobias/.nvm/versions/node/v${NVM_V}/bin/workbox

nvm use $NVM_V > /dev/null
