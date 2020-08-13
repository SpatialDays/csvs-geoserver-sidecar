mkdir -p /rasters_data/csvs_drr_data/
aws --endpoint-url=$S3_URL s3 cp s3://csvs-rasters/ /rasters_data/csvs_drr_data --recursive