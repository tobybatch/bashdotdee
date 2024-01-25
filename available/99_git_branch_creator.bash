# curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
# sudo apt update
# sudo apt install gh
#
# HTTP 401: Bad credentials (https://api.github.com/graphql)
# hint: try authenticating with `gh auth login`

function ghbc {
  ENV=$(pwd)/.ghbc_env
  echo $ENV
  if [ -e $ENV ]; then
    source $ENV
    REPO=" -R $GHBC_REPO "
  fi

  if [ ! -z "$1" ]; then
    ISSUEID=$1
  else
    echo "Enter issue number to create a branch fo the issue"
    return 1
  fi

  TITLE=$(gh issue ${REPO} view ${ISSUEID} | head -n 1 | sed "s/title: //g")
  TITLE=$(echo ${TITLE} | sed "s/title: //g")
  CLEANED=$(echo $TITLE  | sed 's/[^a-zA-Z0-9]/_/g' | awk '{print tolower($0)}')
  BRANCH=$ISSUEID/$CLEANED

  while true; do
    read -p "Create a new branch named \"$BRANCH\"?" yn
    case $yn in
        [Yy]* ) git checkout -b $BRANCH; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
}
