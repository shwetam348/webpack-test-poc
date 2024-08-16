#!/bin/bash

# Define the backup directory inside dist
DIST_DIR="dist"
BACKUP_DIR="$DIST_DIR/backups"

# Create the backups directory inside dist if it does not exist
mkdir -p "$BACKUP_DIR"

# List the contents of the dist folder before backup
echo "-------------------------Listing contents of dist before backup:-------------------------"
ls -al "$BACKUP_DIR"

# Determine the next version number for the backup
# Find the latest version number in the backups directory and increment it
VERSION=$(ls -d "$BACKUP_DIR"/v* 2>/dev/null | awk -F'v' '{print $2}' | sort -V | tail -n 1)
VERSION=${VERSION:-0} # Default to 0 if no versions exist
NEXT_VERSION=$((VERSION + 1))
BACKUP_NAME="v$NEXT_VERSION"

# Create a versioned backup of the dist folder (excluding the backups folder itself)
echo "-------------------------Creating a backup of dist as $BACKUP_NAME...-------------------------"
mkdir -p "$BACKUP_DIR/$BACKUP_NAME"

# Copy the contents to the backup directory while excluding the backups folder itself
find "$DIST_DIR" -mindepth 1 -maxdepth 1 -not -name 'backups' -exec cp -r {} "$BACKUP_DIR/$BACKUP_NAME/" \;

# List the contents of the backups folder
echo "-------------------------Listing contents of $BACKUP_DIR after backup:-------------------------"
ls -al "$BACKUP_DIR"

# Clean up the dist directory (excluding the backups folder)
echo "-------------------------Cleaning up the dist directory (excluding backups)...-------------------------"
find "$DIST_DIR" -mindepth 1 -maxdepth 1 -not -name 'backups' -exec rm -rf {} +

# Install dependencies and run the build command
echo "Installing dependencies..."
npm install --include=dev

echo "Running build..."
npm run build

# List the contents of the dist folder after the build
echo "-------------------------Listing contents of dist after build:-------------------------"
ls -al "$DIST_DIR/backups"
