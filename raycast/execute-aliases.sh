#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title aliases
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName zsh Command
# @raycast.argument1 { "type": "text", "placeholder": "type the alias"}
source ~/.zshrc
eval "$1"
