# see https://github.com/alphagov/govuk-docker/blob/01f524f4bef3e61d9dd8972db27de275a9498afb/Makefile
[ -z "$GOVUK_ROOT_DIR" ] && export GOVUK_ROOT_DIR=$HOME/govuk
[ -z "$GOVUK_DOCKER_DIR" ] && export GOVUK_DOCKER_DIR=$GOVUK_ROOT_DIR/govuk-docker
[ -z "$GOVUK_DOCKER" ] && export GOVUK_DOCKER=$GOVUK_DOCKER_DIR/exe/govuk-docker

echo GOVUK_ROOT_DIR=$GOVUK_ROOT_DIR
echo GOVUK_DOCKER_DIR=$GOVUK_DOCKER_DIR
echo GOVUK_DOCKER=$GOVUK_DOCKER

export PATH=$PATH:$GOVUK_DOCKER_DIR/exe

alias gd="govuk-docker -f $GOVUK_DOCKER_DIR/docker-compose.local.yml"

# gd up -d --force-recreate postgres-17
# gd ps postgres-17
