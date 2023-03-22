BACKUP_URL=$1
BACKUP_SAS=$2

azcopy copy $BACKUP_URL?$BACKUP_SAS vector_data/ --recursive
# mv vector_data/csvs-vector/vanuatu vector_data
# mv vector_data/csvs-vector/solomon vector_data
