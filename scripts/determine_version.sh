#!/bin/bash

#Set Git user identity
git config --global user.email "autogenver@tech.io"
git config --global user.name "autogenerate version"

commit_message=$(git log --format=%s -n 1)

if echo "$commit_message" | grep -qE '^break:'; then
  current_version=$(node -p "require('./package.json').version")
  new_version=$(npm --no-git-tag-version version major --allow-same-version)
  echo "version=$new_version" >> $GITHUB_OUTPUT
  echo "current_version=$current_version" >> $GITHUB_OUTPUT
elif echo "$commit_message" | grep -qE '^feat:'; then
  current_version=$(node -p "require('./package.json').version")
  new_version=$(npm --no-git-tag-version version minor --allow-same-version)
  echo "version=$new_version" >> $GITHUB_OUTPUT
  echo "current_version=$current_version" >> $GITHUB_OUTPUT
elif echo "$commit_message" | grep -qE '^fix:'; then
  current_version=$(node -p "require('./package.json').version")
  new_version=$(npm --no-git-tag-version version patch --allow-same-version)
  echo "version=$new_version" >> $GITHUB_OUTPUT
  echo "current_version=$current_version" >> $GITHUB_OUTPUT
else
  echo "No version change needed."
fi
