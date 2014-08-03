#!/bin/bash
git config user.name "Shippable"
git config user.email "minion@shippable.com"

printf \
  '{"version": "0.1.%d", "timestamp": "%s"}' \
  "$(date +%s)" "$(date)" > version.json

# we need to commit with message containing '[skip ci]' to prevent
# invoking another build for this commit (and creating an infinite loop)
git commit version.json -m "[skip ci] Version bump"

# use the key that Shippable uses to connect to GitHub
ssh-agent bash -c "ssh-add ~/keys/id_${JOB_ID}; git push"

