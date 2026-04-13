if [ ! -e "$HOME/.local/bash_completion.d/bash.d.bash" ]; then
    mkdir -p $HOME/.local/bash_completion.d
    wget -O \
      $HOME/.local/bash_completion.d/bash.d.bash \
      https://raw.githubusercontent.com/tobybatch/bashdotdee/refs/heads/main/bin/bash_completion.bash
fi

# a little klunky but this does not fail on various OS's
[ -f /opt/homebrew/etc/bash_completion ] && . /opt/homebrew/etc/bash_completion
[ -f /opt/homebrew/share/bash-completion/bash_completion ] && ./opt/homebrew/share/bash-completion/bash_completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -d "$HOME"/.local/bash_completion.d ] && for x in "$HOME"/.local/bash_completion.d/*.bash; do source "$x"; done
[ -d "$HOME"/.bash.d/bash_completion.d ] && for x in "$HOME"/.bash.d/bash_completion.d/*.bash; do source "$x"; done
