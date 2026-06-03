if [ -z "$RUBY_VERSION" ]; then
  RUBY_VERSION=3.4.0
fi
[ -d "/opt/homebrew/lib/ruby/gems/$RUBY_VERSION/bin" ] && export PATH=/opt/homebrew/lib/ruby/gems/$RUBY_VERSION/bin:$PATH
