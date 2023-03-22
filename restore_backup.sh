# get SAS_TOKEN from env var called SAS_TOKEN and store it into variable
BACKUP_URL_WITH_SAS_TOKEN=$1
BACKUP_FILE="backup"


if [[ -z "$BACKUP_URL_WITH_SAS_TOKEN" ]] ; then
    echo 'Please, provide backup url.'
    exit 2
fi

{
    # aws --endpoint-url=$S3_URL s3 cp s3://csvs-backups/$BACKUP_FILE . # rewrite this to uze azcopy
    wget $BACKUP_URL_WITH_SAS_TOKEN -O $BACKUP_FILE
    
} || {
    echo 'Failed trying to download the backup file.'
    exit 2
}

# Start restore process
echo Starting restore from backup file $BACKUP_FILE 
mkdir -p /geoserver_data/data/backup_unzipped 
tar -xvzf $BACKUP_FILE -C /geoserver_data/data/backup_unzipped 
cp -r /geoserver_data/data/backup_unzipped/geoserver_data/data/* /geoserver_data/data/ 
echo copying files from abckup to data folder