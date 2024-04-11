#!/bin/bash

# Define variables
Repo_Url="https://github.com/nalisonia/CtrlALtElite-.git"        # Use your own github repo url

FolderPath="$HOME/Desktop/SeniorProjectBackUp/CtrlALtElite-"        # Folder to delete

Directory_Path="$HOME/Desktop/SeniorProjectBackUp"                 # Set the destination directory

# Change directory to the destination directory
cd "$Directory_Path" || { echo "Directory not fouind or incorrect path"; exit 1; }

# Deletes this folder
rm -rf "$FolderPath"

# Initialize a new Git repository
git init

# Create A new Folder to reclone into it, will have the same name
mkdir -p "$FolderPath"

# Clone the repository
git clone "$Repo_Url"

# Check if the git clone command was successful
if [ $? -ne 0 ]; then
    echo "Error: Git clone failed."
    exit 1
fi

echo "Git clone completed successfully."

#once Im done unload plist file launchctl unload ~/Library/LaunchAgents/com.SeniorProjectBackUp.plist
