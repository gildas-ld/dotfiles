#!/bin/bash

# pip list --outdated --format=json | jq -r '.[].name' | xargs -n1 pip install -U

# Get a list of outdated packages using pip and format as JSON, then extract names using jq
outdated_packages=$(pip list --outdated --format=json | jq -r '.[].name')

# Loop through each outdated package and update it
for package in $outdated_packages; do
	echo "Updating $package..."
	pip install --upgrade "$package"
done

echo "All outdated packages have been updated."
