######################
# Cottages

export NTDR_HOME=$HOME/workspace/cottaging/ntdr-pas
export COTTAGE_HOME=$HOME/workspace/cottaging/sites

function cottage-pull {
    if [ -z "$1" ]; then
        return 1
    fi
    BC=$1
    ansible-playbook \
        -i $NTDR_HOME/inventory/cottage-servers \
        --limit=${BC}_live \
        --extra-vars="local=$COTTAGE_HOME/${BC} mysql_root_pw=b191wkm" \
        --tags=db,filesync \
        $NTDR_HOME/pull.yml
}

function cottage-full-setup {
    if [ -z "$1" ]; then
        return 1
    fi

    BC=$1

    if [ ! -d "$COTTAGE_HOME/${BC}" ]; then
       drush make --working-copy "$NTDR_HOME/files/${BC}.make" "$COTTAGE_HOME/${1}"
    fi

    cottage-pull "$1"
}
