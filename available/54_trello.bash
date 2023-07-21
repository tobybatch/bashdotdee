if [ ! -e $HOME/.nvm/versions/node/v18.14.1/bin/trello ]; then
    echo Trello not installed
    echo npm install -g trello-cli
else
    if [ ! -f .trello ]; then
        echo "No .trello file in current directory. Can't continue"
    else
        # trello show-cards -b "$(cat .trello)"
    fi
fi
