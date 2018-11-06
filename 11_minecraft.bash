

minecraft() {
    RCFILE=$HOME/.minecraftrc
    VERSION_DIR=$(ls -lrdt $HOME/.minecraft/versions/* | tail -n 1 | awk '{print $9}')
    VERSION=$(basename $VERSION_DIR)

    if [ "$1" = "--update" ]; then
        # Update stuff

        NATIVES=$(ls -lrdt $HOME/.minecraft/versions/$VERSION/*-natives-* | tail -n 1 | awk '{print $9}')
        echo Version: $VERSION
        echo Natives: $NATIVES
        rm -rf $HOME/.minecraft/versions/$VERSION/$VERSION-natives > /dev/null
        SRC=$NATIVES
        DST=$HOME/.minecraft/versions/$VERSION/$VERSION-natives
        echo Copying
        echo "    $SRC"
        echo " to $DST"
        cp -r $SRC $DST

        ln -s $HOME/.minecraft/assets/indexes/1.12.json $HOME/.minecraft/assets/indexes/1.9.json

        # Now get the tokens
        FULL_PS_LINE=$(ps -ef |grep "userType mojang\|userType legacy"|grep "versionType release")
        ACCESS_TOKEN=$(echo $FULL_PS_LINE | awk '{print $34}')
        UUID=$(echo $FULL_PS_LINE | awk '{print $32}')
        echo "MC_UUID=$UUID" > $RCFILE
        echo "MC_ACCESS_TOKEN=$ACCESS_TOKEN" >> $RCFILE
        cat $RCFILE
    elif [ "$1" = "--install" ]; then
        if [ -z "$HOME_DIRS" ]; then
            echo "You need to set the HOME_DIRS value."
            echo "$ HOME_DIRS=/home"
            return 1
        fi
        for x in $(ls $HOME_DIRS);
        do
            echo "rsync -a $HOME/.minecraft $HOME_DIRS/$x/"
            sudo rsync -a $HOME/.minecraft $HOME_DIRS/$x/
        done
    elif [ "$1" = "--fixperms" ]; then
        UID=$(id -u)
        GID=$(id -g)
        sudo chown -R $UID:$GID $HOME/.minecraft
    else
        # Run it

        if [ -z "$1" ]; then
            MC_USER=$USER
        else
            MC_USER=$1
        fi

        source $RCFILE

        _CP="."
        for x in $(find $HOME/.minecraft/libraries -name "*.jar")
        do
            _CP=$_CP:$x
        done
        _CP=$_CP:$HOME/.minecraft/versions/$VERSION/$VERSION.jar

        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java \
            -Xmx1G \
            -XX:+UseConcMarkSweepGC \
            -XX:+CMSIncrementalMode \
            -XX:-UseAdaptiveSizePolicy \
            -Xmn128M \
            -Djava.library.path=$HOME/.minecraft/versions/$VERSION/$VERSION-natives \
            -cp $_CP \
            net.minecraft.client.main.Main \
                --username $MC_USER \
                --version 1.12.1 \
                --gameDir $HOME/.minecraft \
                --assetsDir $HOME/.minecraft/assets \
                --assetIndex 1.12 \
                --uuid $MC_UUID \
                --accessToken $MC_ACCESS_TOKEN \
                --userType mojang \
                --versionType release
    fi
}
