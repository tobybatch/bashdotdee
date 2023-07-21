# Bash dot Dee

Adds function to my bash shell.

    git clone https://github.com/tobybatch/bashdotdee.git $HOME/.bash.d
    
    cat <<EOF>>.bashrc
    PATH=\$PATH:\$HOME/.bash.d
    for x in ~/.bash.d/enabled/*.bash
    do
        . "\$x"
    done
    EOF

Now use ```bash.d.sh -h``` to manage extensions.

New shells should now have added juice.

