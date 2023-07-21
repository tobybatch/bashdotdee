function countdown() {
  start="$(($(date '+%s') + $1))"
  while [ $start -ge "$(date +%s)" ]; do
    time="$((start - $(date +%s)))"
    printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    sleep 0.1
  done
}

function fixperms {
  while getopts "u:h" options; do
    case $options in
    u) NEW_USER="$OPTARG" ;;
    h)
      echo "Use setfacl to give a single user +rw/+rwx to a subtree of commands, defaults to current user"
      echo "$0 [-u <user_id|user_name] dir1 dir2 ..."
      exit
      ;;
    *) echo "unknown option" ;;
    esac
  done

  if [ -z "$NEW_USER" ]; then
    NEW_USER=$USER
  fi

  if [[ -z $1 ]]; then
    TARGET=$(pwd)
  else
    # TODO Fix the shellcheck SC2124
    # shellcheck disable=SC2124
    TARGET=$@
  fi

  echo -e "${COL_YELLOW}Fix permission on current directory and all sub directories?${COL_RESET}"
  read -p "Are you sure? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo setfacl -dR -m u:"$NEW_USER":rwX -m u:"$(whoami)":rwX "$TARGET"
    sudo setfacl -R -m u:"$NEW_USER":rwX -m u:"$(whoami)":rwX "$TARGET"
  fi
}

function randpass {
  while getopts "hsx" options; do
    case $options in
      h)
        echo   "$(basename "$0") [-s] [-x]"
        echo
        echo "Generates a random 24 character password.  The -s flag restricts the password"
        echo "to alphanumeric characters only.  The -x will use the XKCD random four word"
        echo "password generation (http://xkcd.com/936/)"
      ;;
      x)  xkcd=1;;
      s)  safe=1;;
      *)  echo "Unknown option";;
    esac
  done

  if [ -z $xkcd ]; then
    if [ -z $safe ]; then
      pass=$(</dev/urandom tr -dc 'A-Za-z0-9!@#$%&/()=' | head -c24)
    else
      pass=$(</dev/urandom tr -dc 'A-Za-z0-9' | head -c24)
    fi
  else
    pass=$( \
      grep -v "'" /usr/share/dict/words| \
      shuf -n4 | \
      sed 's/.*/\L&/g' | \
      iconv -f utf8 -t ascii//TRANSLIT \
      )
  fi

  colours="$COL_RED $COL_GREEN $COL_YELLOW $COL_BLUE"

  for word in $pass; do
    colour=$(echo "$colours" | awk '{print $1}')
    echo -en "$colour""$word"
    colours=$(echo "$colours" | awk '{$1="";print $0}')
  done
  echo -e "$COL_RESET"

  echo "$pass" | tr -d '\n' | xsel -ib

  if [ "$?" ]; then
    echo "The password has been pushed to your clipboard, you can paste it where you want it"
  fi
}
