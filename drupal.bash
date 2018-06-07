# Include Drush bash customizations.
if [ -f "/home/tobias/.drush/drush.bashrc" ] ; then
  source /home/tobias/.drush/drush.bashrc
fi


# Include Drush completion.

if [ -f "/home/tobias/.drush/drush.complete.sh" ] ; then
  source /home/tobias/.drush/drush.complete.sh
fi


# Include Drush prompt customizations.

if [ -f "/home/tobias/.drush/drush.prompt.sh" ] ; then
  source /home/tobias/.drush/drush.prompt.sh
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

alias drush=_drush
alias drupal=_drupal
