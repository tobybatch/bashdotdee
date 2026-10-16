# see https://github.com/alphagov/govuk-docker/blob/01f524f4bef3e61d9dd8972db27de275a9498afb/Makefile
[ -z "$GOVUK_ROOT_DIR" ] && export GOVUK_ROOT_DIR=$HOME/govuk
[ -z "$GOVUK_DOCKER_DIR" ] && export GOVUK_DOCKER_DIR=$GOVUK_ROOT_DIR/govuk-docker
[ -z "$GOVUK_DOCKER" ] && export GOVUK_DOCKER=$GOVUK_DOCKER_DIR/exe/govuk-docker

export PATH=$PATH:$GOVUK_DOCKER_DIR/exe

# a little fragile, but it works
export PATH=/Users/tobias.batch/.rbenv/versions/4.0.2/bin:$PATH

alias gd="govuk-docker -f $GOVUK_DOCKER_DIR/docker-compose.local.yml"

export GOVUK_DOCKER_UPDATE_BRANCH=always

# export DATABASE_URL=postgresql://postgres@localhost:5543/content-block-manager_development
export DISABLE_BATCAT=1
export GDS_SSO_STRATEGY=mock
export GOVUK_APP_DOMAIN=dev.gov.uk
export GOVUK_WEBSITE_ROOT=http://www.dev.gov.uk
export JWT_AUTH_SECRET=secret
export PLEK_SERVICE_SIGNON_URI=http://signon.dev.gov.uk
export RAILS_EDITOR=rubymine
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export RBENV_VERSION=4.0.2

# gd up -d --force-recreate postgres-17
# gd ps postgres-17
