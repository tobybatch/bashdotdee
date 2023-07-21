#!/usr/bin/env bash

_bashdotdee_completion() {
  COMPREPLY=($(ls -1 "$HOME/.bash.d/available/"))
}

complete -F _bashdotdee_completion bash.d.sh
