mkdir -p /rasters_data/csvs_drr_data/
# Download 30 years average data
aws --endpoint-url=$S3_URL s3 cp s3://csvs-netcdf/ . --recursive --exclude "*" --include "*_30yrAv.nc"
# Download Monthly data
aws --endpoint-url=$S3_URL s3 cp s3://csvs-netcdf/ . --recursive --exclude "*" --include "*_monthly.nc"