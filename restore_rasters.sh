mkdir -p /rasters_data/csvs_drr_data/
aws --endpoint-url=$S3_URL s3 cp s3://$S3_BUCKET/ /rasters_data/csvs_drr_data --recursive