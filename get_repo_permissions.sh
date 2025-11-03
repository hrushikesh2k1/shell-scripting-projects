#!/bin/bash
################################
# Author: Hrushikesh Boora
# version: v1
#
# Usage: set the github personal access token as environment varibale
#        export GITHUB_TOKEN=""
#
# This script list out the collaborators of the repo
###############################



# Ask the user for a repo name (like org/repo)
echo "Enter the full repo name (e.g., my-org/my-repo):"
read REPO

# Use GitHub API to get list of collaborators and their permissions
curl -s -H "Authorization: token $GITHUB_TOKEN" \
     "https://api.github.com/repos/$REPO/collaborators?per_page=100" \
     | jq -r '.[] | "\(.login): \(.permissions)"'
