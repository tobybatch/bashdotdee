export PATH=$HOME/workspace/Shell-tools:$PATH

function fixperms {
    # HTTPDUSER=$(ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
    HTTPDUSER=www-data

    if [[ -z $1 ]]; then
        echo -e "${COL_YELLOW}Fix permission on current directory and all sub directories?${COL_RESET}"
        read -p "Are you sure? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            TARGET=$(pwd)
        else
            return 0
        fi
    else
        TARGET="$@"
    fi
    sudo setfacl -dR -m u:"$HTTPDUSER":rwX -m u:$(whoami):rwX $TARGET
    sudo setfacl -R -m u:"$HTTPDUSER":rwX -m u:$(whoami):rwX  $TARGET
}
