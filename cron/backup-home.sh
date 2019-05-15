#!/bin/bash

EXCLUDE_LIST="snap Downloads Documents .PlayOnLinux .cache .vagrant.d .sdkman .PyCharmCE2018.3 .p2 .npm .netbeans .googleearth .local/share/Steam .local/share/Trash .local/share/virtualenvs"
HOSTLIST="trafalgar neonkvm"

for x in $HOSTLIST; do
  ping -c1 -q $x 2>&1 > /dev/null
  if [ "$?" == 0 ]; then
    TARGETHOST=$x
    break
  fi
done

if [ -z "$TARGETHOST" ]; then
  echo "No host found"
  exit 1
fi

TARGET=tobias@$TARGETHOST:/export/home

CMD="rsync -a "

for x in $EXCLUDE_LIST; do
  CMD="$CMD --exclude=$USER/$x"
done

CMD="$CMD --size-only $HOME $TARGET"

$CMD
