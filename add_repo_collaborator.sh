#!/bin/bash
############################
# Author: Hrushikesh Boora
# version: v1
#
#
#
#
###############################
OWNER=hrushikesh2k1
REPO=shell-scripting-projects
USERNAME=partheev-boora

curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/collaborators/$USERNAME \
  -d '{"permission":"triage"}'
