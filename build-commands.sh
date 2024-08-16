#!/bin/bash

# Define the backup directory
BACKUP_DIR="backups"

# Create the backups directory if it does not exist
mkdir -p "$BACKUP_DIR"

# List the contents of the dist folder before backup
echo "-------------------------Listing contents of dist before backup:-------------------------"
ls -al dist


# Determine the next version number for the backup
# Find the latest version number and increment it
VERSION=$(ls -d $BACKUP_DIR/v* 2>/dev/null | awk -F'v' '{print $2}' | sort -V | tail -n 1)
VERSION=${VERSION:-0} # Default to 0 if no versions exist
NEXT_VERSION=$((VERSION + 1))
BACKUP_NAME="v$NEXT_VERSION"

# Create a backup of the dist folder with the next version number
echo "-------------------------Creating a backup of dist as $BACKUP_NAME...-------------------------"
cp -r dist "$BACKUP_DIR/$BACKUP_NAME"

# List the contents of the backups folder
echo "-------------------------Listing contents of $BACKUP_DIR after backup:-------------------------"
ls -al "$BACKUP_DIR"

# Install dependencies and run the build command
echo "Installing dependencies..."
npm install --include=dev

echo "Running build..."
npm run build

# Move the backup folder into the dist directory after the build
echo "-------------------------Moving backup into dist directory...-------------------------"
mv "$BACKUP_DIR/$BACKUP_NAME" dist/

# List the contents of the dist folder after moving the backup
echo "-------------------------Listing contents of dist after build:-------------------------"
ls -al dist
