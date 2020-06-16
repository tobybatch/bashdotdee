###########################
# tmux ghistiry persistence

# trap on_exit EXIT
# trap on_usr1 USR1

# on_exit() {
    # history -a
    # trap '' USR1
    # killall -u "$USER" -USR1 bash
# }

# on_usr1() { 
    # history -n
# } 
