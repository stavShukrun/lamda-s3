echo "-----------------------------start running!------------------------------------"
cd infrastructure
tflocal init
tflocal apply -auto-approve
url=$(tflocal output | grep -Eo '(http|https)://[a-zA-Z0-9./?=_%:-]*')'/hello'
counter=0
max_attempts=30
until $(curl --output /dev/null --silent --head --fail http://localhost:4566); do
    if [ ${counter} -eq ${max_attempts} ]; then
        echo "To many try, no connection"
        exit 1
    fi
    counter=$(($counter+1))
    sleep 2
done
echo "-----------------------------Ready!------------------------------------"