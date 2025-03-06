#!/bin/bash

TARGET=$HOME

if [ ! -d "$TARGET/.bash.d" ]; then
  git clone https://github.com/tobybatch/bashdotdee.git $TARGET/.bash.d
fi

echo '' >> $TARGET/.bashrc
echo 'PATH=\$PATH:\$HOME/.bash.d/bin' >> $TARGET/.bashrc
echo 'for x in ~/.bash.d/enabled/*.bash' >> $TARGET/.bashrc
echo 'do' >> $TARGET/.bashrc
echo '    . "\$x"' >> $TARGET/.bashrc
echo 'done' >> $TARGET/.bashrc

ln -sf $TARGET/.bash.d/available/01_path.bash $TARGET/.bash.d/enabled/01_path.bash
