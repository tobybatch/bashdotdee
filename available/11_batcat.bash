if command -v batcat >/dev/null 2>&1 && [ -z "$DISABLE_BATCAT" ]; then
    alias cat=batcat
fi
