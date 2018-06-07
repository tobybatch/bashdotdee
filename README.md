# Bash dot Dee

Adds function to my bash shell.

    git checkout git@github.com:tobybatch/bashdotdee.git $HOME/.bash.d
    cat <<EOF
    for x in ~/.bash.d/*.bash
    do
        . $x
    done
    EOF

New shells should now have added jiuce.

