# Bash dot Dee

Adds function to my bash shell.

    git clone git@github.com:tobybatch/bashdotdee.git $HOME/.bash.d
    
    cat <<EOF>>.bashrc
    for x in ~/.bash.d/*.bash
    do
        . $x
    done
    EOF

New shells should now have added jiuce.

