BACKUP_FILE=$1
ADMIN_PASS=$2

if [[ -z "$BACKUP_FILE" ]] ; then
    echo 'Please, provide backup file name as an argument.'
else
    if [ -z "$ADMIN_PASS" ] ; then
        ADMIN_PASS=geoserver
    fi

    # Download backup file from S3 bucket
    aws --endpoint-url=$S3_URL s3 cp s3://csvs-backups/$BACKUP_FILE .
    # Execute restore if file exists and it is downloaded
    if [ $? -eq 0 ]; then
        echo starting restore from backup file $BACKUP_FILE &&
        mkdir -p /geoserver_data/data/backup_unzipped &&
        mv $BACKUP_FILE tmp.tgz
        tar -xvzf tmp.tgz -C /geoserver_data/data/backup_unzipped &&
        cp -r /geoserver_data/data/backup_unzipped/geoserver_data/data/* /geoserver_data/data/ &&
        echo copying files from abckup to data folder 
        curl -u admin:$ADMIN_PASS -X POST http://geoserver:8080/geoserver/rest/reset -I
        curl -u admin:$ADMIN_PASS -X PUT http://geoserver:8080/geoserver/rest/reload -I
        echo removing tmp files
        rm -rf /geoserver_data/data/backup_unzipped
        echo configuration restored
    else
        echo 'Failed trying to download the backup file.'
    fi
fi
