#!/bin/bash

set -e

source .env

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_NAME="mongo-backup-$TIMESTAMP"
ARCHIVE_NAME="$BACKUP_NAME.tar.gz"

mongodump --host $MONGO_HOST --port $MONGO_PORT --db $MONGO_DB --out $BACKUP_NAME
tar -czf $ARCHIVE_NAME $BACKUP_NAME

aws s3 cp $ARCHIVE_NAME s3://$R2_BUCKET_NAME/ --endpoint-url $R2_ENDPOINT --profile $R2_PROFILE

rm -rf $BACKUP_NAME $ARCHIVE_NAME

echo "Backup $ARCHIVE_NAME uploaded to R2."