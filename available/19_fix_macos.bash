# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo source $HOME/.bashrc >> .bash_profile
# for x in git bash-git-prompt jq nmap npm bat completion xsel; do brew install $x; done

if [[ $OSTYPE == 'darwin'* ]]; then
  # Enable bash completion if present
  [ -f /opt/homebrew/etc/bash_completion ] && . /opt/homebrew/etc/bash_completion

  export PATH=$PATH:/opt/homebrew/bin

  # Some standard aliases
  alias cat='bat'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias grep='grep --color=auto'
  alias l='ls -CF'
  alias la='ls -A'
  alias ll='ls -alF'
  alias ls='ls --color'
fi
