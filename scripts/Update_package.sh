#!/bin/bash

new_version=${1}

echo "new_version=$new_version" >> $GITHUB_OUTPUT
npm --no-git-tag-version version $new_version --allow-same-version
cat package.json
git add package.json
git commit -m "Bump version to $new_version"
git push --quiet
