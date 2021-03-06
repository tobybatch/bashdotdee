#######################
# Docker
if [ ! -z "$(which docker)" ]; then
    export DOCKER_BUILDKIT=1

    function dcleap {
        docker rm $(docker ps --filter=status=exited --filter=status=created -q)
        docker rmi $(docker images -a --filter=dangling=true -q)
    }

    function dbash {
        if [ -z "$1" ]; then
            CONTAINER=`docker ps |head -n2 |tail -n1|awk '{ print $1 }'`
        else
            CONTAINER=$1
        fi
        docker exec -ti $CONTAINER /bin/bash
    }

    function dnuke {
        if [ ! -z "$1" ]; then
            docker kill $1
            docker rm $1
        fi
    }

    function docker-clear-log {
        if [[ -z $1 ]]; then
            read -p "No container specified clear all, Are you sure? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]
            then
                sudo su - root -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"
            fi
            return 0
        fi

        if [[ "$(docker ps -aq -f name=^/${1}$ 2> /dev/null)" == "" ]]; then
            echo "Container \"$1\" does not exist, exiting."
            return 1
        fi

        log=$(docker inspect -f '{{.LogPath}}' $1 2> /dev/null)
        truncate -s 0 $log
    }

fi
