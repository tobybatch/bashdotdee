function cd {
        builtin cd "$@"
        pwd > ~/.last_dir
}
