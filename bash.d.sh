#!/bin/bash

BASHDDIR=$(dirname $0)

USAGE="`basename $0` [-e <config>|-d config|-l]"

function usage {
    echo $USAGE
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
  SOURCE=$BASHDDIR/avaiable/$1
  TARGET=$BASHDDIR/enabled/$1

  if [ ! -e "$SOURCE" ]; then
    echo "No such config ($1)"
    exit 1
  fi

  if [ -L "$TARGET" ]; then
    echo "Config already enabled ($1)"
    exit 1
  fi

  ln -s $(realpath $SOURCE) $TARGET
}

function disable_config {
  TARGET=$BASHDDIR/enabled/$1
  rm -f $TARGET
}

function list_configs {
  ls -1 $BASHDDIR/avaiable
}

while getopts "e:d:lh" options; do
    case $options in
        e) enable_config $OPTARG; exit;;
        d) disable_config $OPTARG; exit;;
        l) list_configs; exit;;
        h) usage; exit;;
    esac
done

# If we got this far without exiting it's a list currently enabled
ls -1 $BASHDDIR/enabled
