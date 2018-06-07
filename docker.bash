#######################
# Docker
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

