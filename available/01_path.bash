export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.bash.d/bin
export PATH=$PATH:$HOME/.local/bin
[ -d "$HOME/.screenlayout" ] &&export PATH=$PATH:$HOME/.screenlayout
[ -d "/opt/homebrew/bin" ] && export PATH=/opt/homebrew/bin:$PATH
[ ! -z "$PYTHON_VERSION" ] && [ -d "/opt/homebrew/bin" ] && [ -d "/opt/homebrew/opt/python@${PYTHON_VERSION}" ] && export PATH="/opt/homebrew/opt/python@${PYTHON_VERSION}/libexec/bin:$PATH"
