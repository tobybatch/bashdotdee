# https://github.com/magicmonty/bash-git-prompt/blob/master/README.md
# git_prompt_make_custom_theme Single_line_Ubuntu
# sed -i 's/${White}${Time12a}${ResetColor} //g' .git-prompt-colors.sh

GIT_PROMPT_THEME=Single_line_Ubuntu

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

if [[ $OSTYPE == 'darwin'* ]]; then
    if [[ $OSTYPE == 'darwin'* ]]; then
    if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
      __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
      GIT_PROMPT_ONLY_IN_REPO=1
      source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
    fi
  fi
fi

if [ -f "$HOME/.git-prompt-colors.sh" ]; then
    GIT_PROMPT_THEME=Custom
    source $HOME/.git-prompt-colors.sh 2>&1 > /dev/null
fi

