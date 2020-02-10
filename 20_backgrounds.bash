function setBg {
    feh --randomize --bg-fill $HOME/var/images/background/*
}

function rotateBg {
    while sleep 1200; do
        setBg
    done
}
