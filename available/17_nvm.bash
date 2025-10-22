if [ -z "$NVM_V" ]; then
  export NVM_V=18.14.1
fi

export NVM_DIR="$HOME/.nvm"
if [[ $OSTYPE == 'darwin'* ]]; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
else
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ ! -d "${HOME}/.nvm/versions/node/v${NVM_V}" ]; then
  nvm install ${NVM_V}
fi

export PATH=$PATH:$HOME/.nvm/versions/node/v${NVM_V}/bin/workbox

nvm use $NVM_V > /dev/null
