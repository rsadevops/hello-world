#!/bin/bash

#Set Git user identity
git config --global user.email "autogenver@tech.io"
git config --global user.name "autogenerate version"


#Determine version
commit_message=$(git log --format=%s -n 1)

if echo "$commit_message" | grep -qE '^break:'; then
  new_version=$(npm --no-git-tag-version version major --allow-same-version)

elif echo "$commit_message" | grep -qE '^feat:'; then
  new_version=$(npm --no-git-tag-version version minor --allow-same-version)

elif echo "$commit_message" | grep -qE '^fix:'; then
  new_version=$(npm --no-git-tag-version version patch --allow-same-version)

else
  new_version=$(node -p "require('./package.json').version")
fi

#Update package.json
echo "new_version=$new_version" >> $GITHUB_OUTPUT

npm --no-git-tag-version version $new_version --allow-same-version

git add package.json
git commit -m "Bump version to $new_version"
git push --quiet