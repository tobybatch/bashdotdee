if [ -z "$NVM_V" ]; then
  export NVM_V=18.14.1
fi

if [[ $OSTYPE == 'darwin'* ]]; then
  export NVM_DIR=/opt/homebrew/Cellar/nvm/0.40.1
else
  export NVM_DIR="$HOME/.nvm"
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ ! -d "${HOME}/.nvm/versions/node/v${NVM_V}" ]; then
  nvm install ${NVM_V}
fi

export PATH=$PATH:$HOME/.nvm/versions/node/v${NVM_V}/bin/workbox

nvm use $NVM_V > /dev/null
