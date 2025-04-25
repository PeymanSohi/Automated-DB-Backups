#!/bin/bash

set -e

source .env

LATEST_BACKUP=$(aws s3 ls s3://$R2_BUCKET_NAME/ --endpoint-url $R2_ENDPOINT --profile $R2_PROFILE | sort | tail -n 1 | awk '{print $4}')
aws s3 cp s3://$R2_BUCKET_NAME/$LATEST_BACKUP . --endpoint-url $R2_ENDPOINT --profile $R2_PROFILE

ARCHIVE_NAME=$LATEST_BACKUP
BACKUP_NAME=$(basename $LATEST_BACKUP .tar.gz)

tar -xzf $ARCHIVE_NAME
mongorestore --host $MONGO_HOST --port $MONGO_PORT $BACKUP_NAME

rm -rf $BACKUP_NAME $ARCHIVE_NAME

echo "Restored backup from $ARCHIVE_NAME."