# https://developer.1password.com/docs/cli/get-started/

if [ ! -e /usr/bin/op ]; then
    echo -e $COL_MAGENTA"1-pass cli not installed"$COL_RESET

    echo -e $COL_GREEN"Add the key for the 1Password apt repository:"$COL_RESET
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
    sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

    echo -e $COL_GREEN"Add the 1Password apt repository:"$COL_RESET
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | sudo tee /etc/apt/sources.list.d/1password.list

    echo -e $COL_GREEN"Add the debsig-verify policy:"$COL_RESET
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
￼
    echo -e $COL_GREEN"Install 1Password CLI:"$COL_RESET
    sudo apt update && sudo apt install 1password-cli
fi
