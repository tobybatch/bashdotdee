#!/usr/bin/env bash

_bashdotdee_completion() {
#  echo SSSSSSSSSSSSSSSSSS
#  echo $@
#  if [ ! -z "$1" ]; then
#    COMPREPLY="-e -d -l -h"
#  else
    COMPREPLY=($(ls -1 "$HOME/.bash.d/available/"))
#  fi
}

complete -F _bashdotdee_completion bash.d.sh
