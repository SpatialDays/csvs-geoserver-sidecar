FROM python:3.7.8-alpine3.12

RUN pip install awscli

ENTRYPOINT ["tail", "-f", "/dev/null"]

ENV AWS_ACCESS_KEY_ID **None**
ENV AWS_SECRET_ACCESS_KEY **None**
ENV AWS_DEFAULT_REGION eu-west-1
ENV S3_BUCKET csvs-rasters
ENV S3_S3V4 no
ENV S3_URL http://s3-uk-1.sa-catapult.co.uk

COPY restore_rasters.sh /restore_rasters.sh