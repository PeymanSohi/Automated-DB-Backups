#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
BACKUP_NAME="mongo_backup_$TIMESTAMP"
DUMP_DIR="/tmp/$BACKUP_NAME"
ARCHIVE="/tmp/$BACKUP_NAME.tar.gz"
BUCKET="mongo-backups"

# Dump database
mongodump --out $DUMP_DIR

# Compress dump
tar -czf $ARCHIVE -C /tmp $BACKUP_NAME

# Upload to Cloudflare R2
aws s3 cp $ARCHIVE s3://$BUCKET/ --profile r2

# Clean up
rm -rf $DUMP_DIR $ARCHIVE

echo "✅ Backup $BACKUP_NAME uploaded to R2"
