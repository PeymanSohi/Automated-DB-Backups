#!/bin/bash

set -e

sudo apt update && sudo apt install -y mongodb-clients awscli

echo "AWS and MongoDB tools installed."

echo "Configure AWS CLI for R2:"
aws configure --profile $R2_PROFILE

# Optional: seed MongoDB
mongo --eval "db = connect('$MONGO_HOST:$MONGO_PORT/$MONGO_DB'); db.test.insert({name: 'sample', created_at: new Date()})"
echo "MongoDB seeded with sample data."
