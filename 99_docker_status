#######################
# Docker
if [ ! -z "$(which docker)" ]; then

    if [ ! -z "$(which ccze)" ]; then
        # docker ps -a | awk '{print $2 $4 $5 $6 $7}' | ccze -A
        docker ps -a | ccze -A
    else
        docker ps -a
    fi

fi
