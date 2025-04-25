#!/bin/bash

set -e

source .env

echo "Seeding database with test data..."
mongo --eval "db = connect('$MONGO_HOST:$MONGO_PORT/$MONGO_DB'); db.test.insert({load: Math.random(), timestamp: new Date()})"

echo "Running backup..."
./backup.sh