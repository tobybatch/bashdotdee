# alias android-connect="mtpfs -o allow_other /media/nexus6p"
# alias android-disconnect="fusermount -u /media/nexus6p"
function unlock {
    if [ -z "$1" ]; then
      if [ -f $HOME/.local/unlock.code ]; then
        PASS=$(cat $HOME/.local/unlock.code)
      fi
    else
      PASS=$1
    fi
    adb shell input keyevent KEYCODE_WAKEUP && \
    adb shell input text $PASS && \
    adb shell input keyevent KEYCODE_ENTER
}
