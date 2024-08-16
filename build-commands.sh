#!/bin/bash

# List the contents of the dist folder before backup
echo "Listing contents of dist before backup:"
ls -al dist

# Generate a timestamp
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
echo "Timestamp: $TIMESTAMP"

# Create a temporary directory for the backup
mkdir -p /tmp/backup

# Copy the dist folder to the temporary location with the timestamp
echo "Creating a backup of dist..."
cp -r dist /tmp/backup/backup_$TIMESTAMP

# Move the backup from the temporary location to inside the dist directory
echo "Moving backup to dist..."
mv /tmp/backup/backup_$TIMESTAMP dist/

# List the contents of the dist folder after backup
echo "Listing contents of dist after backup:"
ls -al dist

# Install dependencies and run the build command
echo "Installing dependencies..."
npm install --include=dev

echo "Running build..."
npm run build

# List the contents of the dist folder after the build
echo "Listing contents of dist after build:"
ls -al dist
