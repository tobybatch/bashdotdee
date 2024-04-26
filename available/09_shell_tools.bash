function version_bump() {
    if [ -d .git ] && [ -e version.txt ]; then
        git commit -am "chore: bump verstion to $(cat version.txt)"
        return 0
    else
        echo No a git repo or no version.txt
        return 1
    fi
}

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

function vbump {
  local OPTIND h b d
  while getopts "hb:d" options; do
    case $options in
      h)
        echo   "$(basename "$0") [-h] [-b] [version file]"
        echo
        echo "Bumps a version file in semver, then commits it to git"
        echo "-b Level to bump, (M)ajor, (m)inor, (p)atch"
        echo "   e.g. vbump                   # Patch bump in version.txt, 2.4.6 becomes 2.4.7"
        echo "   e.g. vbump -b m              # Minor bump in version.txt, 2.4.6 becomes 2.5.0"
        echo "   e.g. vbump version.foo       # Patch bump in version.foo, 2.4.6 becomes 2.4.7"
        echo "   e.g. vbump -b M version.foo  # Major bump in version.foo, 2.4.6 becomes 3.0.0"
        echo "-y Auto write the changes to the file"
        return 0
      ;;
      b)  BUMP=$OPTARG;;
      d)  DONT_WRITE=$OPTARG;;
      *)  echo "Unknown option";;
    esac
  done
  shift $((OPTIND-1))

  if [ ! -z "$1" ]; then
    VPATH="$1"
  else
    VPATH="version.txt"
  fi
  if [ ! -e "$VPATH" ]; then
    echo "Unable to locate version file $VPATH"
    return 1
  fi

  VERSION=$(cat $VPATH)
  VERSION="${VERSION#[vV]}"
  VERSION_MAJOR="${VERSION%%\.*}"
  VERSION_MINOR="${VERSION#*.}"
  VERSION_MINOR="${VERSION_MINOR%.*}"
  VERSION_PATCH="${VERSION##*.}"

  echo "Current Version:  ${VERSION}"

  while [ "M" != "$BUMP" ] && [ "m" != "$BUMP" ] && [ "p" != "$BUMP" ]; do
    echo "(M)ajor, (m)inor, (p)patch?"
    read -r BUMP
  done

  case $BUMP in
    M)
      VERSION_MAJOR=$((VERSION_MAJOR + 1))
      VERSION_MINOR=0
      VERSION_PATCH=0
      ;;
    m)
      VERSION_MINOR=$((VERSION_MINOR + 1))
      VERSION_PATCH=0
      ;;
    p)
      VERSION_PATCH=$((VERSION_PATCH + 1))
      ;;
    *)
      echo "Unreachable?"
      return 1
      ;;
  esac

  VERSION="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
  echo "Proposed Version: ${VERSION}"

  if [ -z "$DONT_WRITE" ]; then
    echo $VERSION > $VPATH
    echo "Written new version ($VERSION) to $VPATH"
  fi

  if [ -e $(dirname $VPATH)/.git ]; then
      git -C $(dirname $VPATH) commit -m "chore: bump version to $VERSION" $(dirname $VPATH)/version.txt
  fi
}
