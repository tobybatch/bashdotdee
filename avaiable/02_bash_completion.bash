# anything in $HOME/.local/bash_completion.d ending .bash get included
source "$HOME/.local/bash_completion.d/*.bash"

# other environment specific scripts should not end .bash, e.g. see 87_django.bash
