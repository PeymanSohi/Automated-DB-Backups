#!/bin/bash

BUCKET="mongo-backups"
PROFILE="r2"

# Download the latest backup
LATEST=$(aws s3 ls s3://$BUCKET/ --profile $PROFILE | sort | tail -n 1 | awk '{print $4}')
aws s3 cp s3://$BUCKET/$LATEST /tmp/$LATEST --profile $PROFILE

# Extract and restore
tar -xzf /tmp/$LATEST -C /tmp
mongorestore /tmp/${LATEST%.tar.gz}

echo "✅ Database restored from $LATEST"
