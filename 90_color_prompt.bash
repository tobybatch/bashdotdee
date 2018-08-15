if [ -f $HOME/.env ]; then
    source $HOME/.env
fi

if [ -z "$HOSTNAME_COLOUR" ]; then
    HOSTNAME_COLOUR='38;5;33m'
fi

if [ "$TERM" == "screen" ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '
fi

PS1_GIT="__git_ps1 "
PS1_USER='\[$(tput bold)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]'
PS1_HOST='\[$(tput bold)\]\[$(tput sgr0)\]\[\033['$HOSTNAME_COLOUR'\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]'
PS1_DIR='\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;87m\]\W\[$(tput sgr0)\]'

declare -f __drush_ps1 > /dev/null
if [ "$?" == 0 ]; then
    PS1_DRUSH='$(__drush_ps1 "[%s]") \\\$ '
else
    PS1_DRUSH=' \\\$ '
fi

export PROMPT_COMMAND="$PS1_GIT \"$PS1_USER@$PS1_HOST:$PS1_DIR\" \"$PS1_DRUSH\" "
