#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Github Repos
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
# @raycast.packageName Developer Util

# Documentation:
# @raycast.description Search through your own public and private Github repos using Github CLI
# @raycast.author Carlos Castillo
# @raycast.authorURL https://github.com/regexPattern

gh repo list --json name,description,visibility,url
