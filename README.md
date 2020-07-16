# A repo to build a docker image to run as a sidecar for Geoserver running in kubernetes

The image contains a bash script `restore_rasters.sh` to download data stored in S3 bucket in a folder (that should be shared with geoserver when we run the container from this image alognside the geoserver container in the same pod)
