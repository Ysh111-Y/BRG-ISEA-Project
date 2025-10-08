#!/bin/bash
# Backup Script with date validation using regex
BACKUP_DIR="/home/$(whoami)/backups"
SOURCE_DIR="/home/$(whoami)/BRG-ISEA-Project"
DATE=$(date +%Y-%m-%d)
# Validate date format using regex
if [[ ! $DATE =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Error: Invalid date format"
    exit 1

fi
mkdir -p $BACKUP_DIR
echo "Starting backup: $DATE"
tar -czf $BACKUP_DIR/backup_$DATE.tar.gz $SOURCE_DIR 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup successful: backup_$DATE.tar.gz"
    echo "Backup size: $(du -h $BACKUP_DIR/backup_$DATE.tar.gz | cut -f1)"
else
    echo "Backup failed!"
fi
