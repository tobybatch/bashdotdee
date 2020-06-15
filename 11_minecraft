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

        cp -r $HOME/.minecraft/assets $HOME/.minecraft/_assets
        cp -r $HOME/.minecraft/libraries $HOME/.minecraft/_libraries

        # Now get the tokens
        FULL_PS_LINE=$(ps -ef |grep "userType mojang\|userType legacy"|grep "gameDir")

        for x in $FULL_PS_LINE; do
          if [ "$x" == "--uuid" ]; then
            UUIDNEXT=1
          elif [ "$x" == "--accessToken" ]; then
            ACCESSTOKENNEXT=1
          elif [ "$x" == "--version" ]; then
            VERSIONNEXT=1
          elif [ "$x" == "--assetIndex" ]; then
            ASSETINDEXNEXT=1
          elif [ ! -z "$UUIDNEXT" ]; then
            UUID=$x
            unset UUIDNEXT
          elif [ ! -z "$ACCESSTOKENNEXT" ]; then
            ACCESSTOKEN=$x
            unset ACCESSTOKENNEXT
          elif [ ! -z "$VERSIONNEXT" ]; then
            VERSION=$x
            unset VERSIONNEXT
          elif [ ! -z "$ASSETINDEXNEXT" ]; then
            ASSETINDEX=$x
            unset ASSETINDEXNEXT
          fi
        done

        echo "MC_UUID=$UUID" > $RCFILE
        echo "MC_ACCESSTOKEN=$ACCESSTOKEN" >> $RCFILE
        echo "MC_VERSION=$VERSION" >> $RCFILE
        echo "MC_ASSETINDEX=$ASSETINDEX" >> $RCFILE
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
        _CP=$_CP:/home/tobias/.minecraft/libraries/org/apache/commons/commons-lang3/3.3.2/commons-lang3-3.3.2.jar
        for x in $(find $HOME/.minecraft/_libraries -name "*.jar")
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
            -Djava.library.path=/home/tobias/.minecraft/versions/$VERSION/$VERSION-natives \
            -Dminecraft.launcher.brand=java-minecraft-launcher \
            -Dminecraft.launcher.version=1.6.89-j \
            -Dminecraft.client.jar=/home/tobias/.minecraft/versions/$VERSION/$VERSION.jar \
            -cp $_CP \
                net.minecraft.client.main.Main \
            --username $MC_USER \
            --version $MC_VERSION \
            --gameDir $HOME/.minecraft \
            --assetsDir $HOME/.minecraft/_assets \
            --assetIndex $MC_ASSETINDEX \
            --uuid $MC_UUID \
            --accessToken $MC_ACCESS_TOKEN \
            --userProperties {} \
            --userType mojang
    fi
}
