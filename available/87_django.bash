if [ ! -e "$HOME/.local/bash_completion.d/django_bash_completion" ]; then 
    wget -O \
      $HOME/.local/bash_completion.d/django_bash_completion \
      https://raw.githubusercontent.com/django/django/main/extras/django_bash_completion
fi

source $HOME/.local/bash_completion.d/django_bash_completion
