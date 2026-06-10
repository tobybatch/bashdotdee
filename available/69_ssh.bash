shopt -s extglob

for x in ~/.ssh/id!(*.*)
do
    if [ -f "$x" ]; then
        FINGERPRINT=$(ssh-keygen -lf "$x" 2>/dev/null | awk '{print $2}')
        if [ -n "$FINGERPRINT" ]; then
            if ! ssh-add -l | grep -q "$FINGERPRINT"; then
                ssh-add "$x"
            fi
        fi
        
    fi
done
