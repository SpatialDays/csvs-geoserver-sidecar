BACKUP_FILE=$1
GEOSERVER_CRED=$2

if [[ -z "$BACKUP_FILE" ]] ; then
    echo 'Please, provide backup file name as an argument.'
    exit 2
fi

if [ -z "$GEOSERVER_CRED" ] ; then
    GEOSERVER_CRED=admin:geoserver
fi

{
    curl -f -u $GEOSERVER_CRED -X GET http://geoserver:8080/geoserver/rest/reset -I
} || {
    echo 'The provided credentials are not valid.'
    exit 2
}

{
    aws --endpoint-url=$S3_URL s3 cp s3://csvs-backups/$BACKUP_FILE .
} || {
    echo 'Failed trying to download the backup file.'
    exit 2
}

# Start restore process
echo Starting restore from backup file $BACKUP_FILE &&
mkdir -p /geoserver_data/data/backup_unzipped &&
mv $BACKUP_FILE tmp.tgz
tar -xvzf tmp.tgz -C /geoserver_data/data/backup_unzipped &&
cp -r /geoserver_data/data/backup_unzipped/geoserver_data/data/* /geoserver_data/data/ &&
echo copying files from abckup to data folder
curl -u $GEOSERVER_CRED -X POST http://geoserver:8080/geoserver/rest/reset -I
curl -u $GEOSERVER_CRED -X PUT http://geoserver:8080/geoserver/rest/reload -I
echo removing tmp files
rm -rf /geoserver_data/data/backup_unzipped
echo configuration restored