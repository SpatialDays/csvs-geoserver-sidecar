mkdir -p /netcdf_data/csvs_climate_data/
aws --endpoint-url=$S3_URL s3 cp s3://csvs-netcdf/ /netcdf_data/csvs_climate_data/ --recursive