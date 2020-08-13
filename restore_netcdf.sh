mkdir -p /netcdf_data/csvs_climate_data/
# Download 30 years average data
aws --endpoint-url=$S3_URL s3 cp s3://csvs-netcdf/ /netcdf_data/csvs_climate_data/ --recursive --exclude "*" --include "*_30yrAv.nc"
# Download Monthly data
aws --endpoint-url=$S3_URL s3 cp s3://csvs-netcdf/ /netcdf_data/csvs_climate_data/ --recursive --exclude "*" --include "*_monthly.nc"