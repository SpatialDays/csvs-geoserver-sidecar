BACKUP_URL=$1
BACKUP_SAS=$2
mkdir -p /rasters_data/csvs_drr_data/
# aws --endpoint-url=$S3_URL s3 cp s3://csvs-rasters/ /rasters_data/csvs_drr_data --recursive
azcopy copy $BACKUP_URL?$BACKUP_SAS rasters_data/csvs_drr_data --recursive
