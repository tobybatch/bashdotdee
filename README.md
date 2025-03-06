# Bash dot Dee

## TLDR;

    curl -o - https://raw.githubusercontent.com/tobybatch/bashdotdee/refs/heads/main/install.sh | bash

## Manual install

Adds function to my bash shell.

    git clone https://github.com/tobybatch/bashdotdee.git $HOME/.bash.d

    cat <<EOF>>.bashrc
    PATH=\$PATH:\$HOME/.bash.d/bin
    for x in ~/.bash.d/enabled/*.bash
    do
        . "\$x"
    done
    EOF

Now use ```bash.d.sh -h``` to manage extensions.

New shells should now have added juice.

## Usage

After installing open an new shell.

### Shou usage

    bash.d.sh -h

### List modules

    bash.d.sh -l

### Enable a module

    bash.d.sh -e <MODULE_NAME>

### Disable a module

    bash.d.sh -d <MODULE_NAME>

### Examples

Enable batcat

    bash.d.sh -e 11_batcat.bash

Disable python

    bash.d.sh -d 14_python.bash
