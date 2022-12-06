function cd {
        builtin cd "$@"
        pwd > ~/.last_dir
        if [ -e $(pwd)/.nvmrc ]; then
                nvm use
        fi

        if [ -e $(pwd)/Pipfile ]; then
                pipenv shell
        fi
}
