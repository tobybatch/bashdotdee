# alias android-connect="mtpfs -o allow_other /media/nexus6p"
# alias android-disconnect="fusermount -u /media/nexus6p"
function unlock {
    adb shell input keyevent KEYCODE_WAKEUP && \
    adb shell input text $1 && \
    adb shell input keyevent KEYCODE_ENTER
}
