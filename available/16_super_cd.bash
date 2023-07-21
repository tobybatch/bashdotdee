function cd {
    # Record the new dir
    builtin cd "$@"
    pwd > ~/.last_dir

    # if we have a node env, then initialise it
    if [ -e $(pwd)/.nvmrc ]; then
        nvm use
    fi

    # if we have a pip env, then initialise it
    if [ -e Pipfile.lock ]; then
        # PIPENV=$(pipenv --venv)
        # source "${PIPENV}/bin/activate" > /dev/null
        pipenv shell
    fi
}

export PIPENV_IGNORE_VIRTUALENVS=1
alias cdl="cd $(cat ~/.last_dir)"
