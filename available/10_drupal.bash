# Include Drush bash customizations.
if [ -f "$HOME/.drush/drush.bashrc" ] ; then
  source $HOME/.drush/drush.bashrc
fi


# Include Drush completion.

if [ -f "$HOME/.drush/drush.complete.sh" ] ; then
  source $HOME/.drush/drush.complete.sh
fi


# Include Drush prompt customizations.

if [ -f "$HOME/.drush/drush.prompt.sh" ] ; then
  source $HOME/.drush/drush.prompt.sh
fi

search_up() {
    local LOOK=${PWD%/}
    while [[ -n $LOOK ]]; do
        [[ -e $LOOK/$1 ]] && {
            echo "$LOOK"
            return
        }
        LOOK=${LOOK%/*}
    done
    [[ -e /$1 ]] && echo /
}

_drupal() {
    ROOT=`search_up vendor`
    if [ ! -z "$ROOT" ]; then
        $ROOT/vendor/bin/drupal $@
    else
        drupal $@
    fi
}

_drush() {
    ROOT=`search_up vendor`
    if [ ! -z "$ROOT" ]; then
        $ROOT/vendor/bin/drush $@
    else
        drush $@
    fi
}

_console() {
    ROOT=`search_up bin`
    if [ ! -z "$ROOT" ]; then
        $ROOT/bin/console $@
    else
        exit 1
    fi
}

alias drush=_drush
alias drupal=_drupal
alias console=_console

export DR_PORT=8989
export PATH=$PATH:$HOME/.config/composer/vendor/drush
