#######################
# Docker
if [ ! -z "$(which docker)" ]; then

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

    if [ ! -z "$(which ccze)" ]; then
        # docker ps -a | awk '{print $2 $4 $5 $6 $7}' | ccze -A
        docker ps -a | ccze -A
    else
        docker ps -a
    fi

fi