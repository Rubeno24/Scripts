#!/bin/bash

# Read the number from the var.txt file
number=$(<var.txt)

# Increment the number that corresponds to the number with ctrlaltelite folder
# The number will only go up to 2 since we have 3 folders
((number++))

# Make sure the number doesnt go past 2 and if it does set it to 0
if ((number > 2)); then
    number=0
fi

# Rewrite the entire file with the updated number
echo "$number" > var.txt

# Print the updates number
echo "The updated number is: $number"


# Variables

# The Url to the repo
Repo_Url="https://github.com/nalisonia/CtrlALtElite-.git" 

# Path to where our folders are located
FolderPath="$HOME/Desktop/SeniorProjectBackUp"                     

# Updated Folder Path with a number 0,1,2 in it so it correspsonds to the correct folder
FolderPathNumber="$HOME/Desktop/SeniorProjectBackUp/CtrlALtElite-$number"

# change directory to where the folders are located
cd "$FolderPath" || { echo "Directory not found or incorrect path"; exit 1; }

# Remove the folder with the number between 0 and 2 so we can create it again and clone to it
rm -rf "$FolderPathNumber"

# Create a new folder with the same name
mkdir -p "$FolderPathNumber"
    
# Change directory to the new folder
cd "$FolderPathNumber" || { echo "Directory not found or incorrect path"; exit 1; }

# Clone the repository into that folder with the number between 0 and 2 in it 
git clone "$Repo_Url"

# Check if the git clone command was successful
if [ $? -ne 0 ]; then
    echo "Error: Git clone failed."
    exit 1
fi

echo "Git clone completed successfully."

#once Im done unload plist file launchctl unload ~/Library/LaunchAgents/com.SeniorProjectBackUp.plist



