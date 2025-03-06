#!/bin/bash

BASHDDIR=$(dirname "$0")/..

# shellcheck disable=SC2086
USAGE="$(basename $0) [-e <config>|-d config|-l]"

function usage {
    echo "$USAGE"
    cat <<EOF
Enable, disable or list available bash config. Run without any parameters it
will list currently enabled configs.

-e <config name>
    Enable the specified configuration.
-d <config name>
    Disable the specified configuration.
-l  List the available configurations.
EOF
}

function enable_config {
  # first arg is the -e so renove it
  shift
  exit_state=0
  for src in "$@"; do
      SOURCE=$BASHDDIR/available/$src
      TARGET=$BASHDDIR/enabled/$src

      if [ ! -e "$SOURCE" ]; then
        echo "No such config ($1)"
        exit_state=1
      fi

      if [ -L "$TARGET" ]; then
        echo "Config already enabled ($1)"
        exit_state=1
      fi

      # shellcheck disable=SC2046
      ln -s $(realpath "$SOURCE") "$TARGET"
      echo "Enabled $src"
  done
  exit "$exit_state"
}

function disable_config {
  TARGET=$BASHDDIR/enabled/$1
  rm -f "$TARGET"
}

function list_configs {
  ls -1 "$BASHDDIR/available"
}

while getopts "e:d:lh" options; do
    case $options in
        e) enable_config "$@"; exit;;
        d) disable_config "$@"; exit;;
        l) list_configs; exit;;
        h) usage; exit;;
        *) usage; exit;;
    esac
done

# If we got this far without exiting it's a list currently enabled
ls -1 "$BASHDDIR/enabled"
