function createBindMount() {
    read -p "Mount name to create:" name
    local bindmountdir=/opt/docker/

    if [ -z "$name" ]; then
    echo "ERROR: Missing source for bind mount"
    exit 1
    fi

    echo "creating bind mount.."
    docker volume create --driver local \
    --opt device=$bindmountdir$name \
    --opt o=bind $name
    echo "name: $name"
    echo "created at: $bindmountdir$name"
}

# While loop to create bind mounts using local driver
createBindMount
while IFS= read -n1 -r -p "Create another bind mount? [y,n]" && [[ $REPLY != q ]]; do
echo ""
case $REPLY in 
    y|Y) createBindMount $REPLY ;;
    n|N) break ;;
esac
done