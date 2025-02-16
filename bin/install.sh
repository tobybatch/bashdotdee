cat <<EOF>>.bashrc
# ADDED BY BASHDOTDEE
PATH=\$PATH:\$HOME/.bash.d
for x in ~/.bash.d/enabled/*.bash
do
    . "\$x"
done
# END OF BASHDOTDEE
EOF
