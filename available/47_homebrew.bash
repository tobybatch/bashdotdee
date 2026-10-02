if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
  $(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)
fi
