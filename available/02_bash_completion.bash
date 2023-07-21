# anything in $HOME/.local/bash_completion.d ending .bash get included
for x in "$HOME/.local/bash_completion.d/*.bash"; do
    source "$x"
done
# other environment specific scripts should not end .bash, e.g. see 87_django.bash
