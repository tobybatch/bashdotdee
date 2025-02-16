cat <<EOF>>.bashrc
PATH=\$PATH:\$HOME/.bash.d
for x in ~/.bash.d/enabled/*.bash
do
    . "\$x"
done
EOF
