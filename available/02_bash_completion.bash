if [ ! -e "$HOME/.local/bash_completion.d/bash.d.bash" ]; then
    wget -O \
      $HOME/.local/bash_completion.d/bash.d.bash \
      https://raw.githubusercontent.com/tobybatch/bashdotdee/main/bash_completion.bash
fi

# anything in $HOME/.local/bash_completion.d ending .bash get included
for x in "$HOME"/.local/bash_completion.d/*.bash; do
    source "$x"
done
# other environment specific scripts should not end .bash, e.g. see 87_django.bash
