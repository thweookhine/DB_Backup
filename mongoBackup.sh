#!/bin/bash

# Load Configuration
source backupConf.sh
EXIT_CODE=0
ERROR_CODE=1
echo "mongoBackup.sh shell starts running"
mkdir -p "$BACKUP_DIR"
mongodump --uri="$MONGO_URI" --db="$DATABASE_NAME" --out="$BACKUP_DIR"

for file in $BACKUP_DIR/$DATABASE_NAME/*.bson; do bsondump "$file" > "${file%.bson}.json"; done

# Report result
if [ $? -eq 0 ]; then
  echo "Backup successful! Saved to $BACKUP_DIR"
  echo "mongoBackup.sh shell terminated successfully"
  exit $EXIT_CODE
else
  echo "Backup failed."
  exit $ERROR_CODE
fi