#!/bin/bash
# Push the existing local repo to a new private GitHub remote.
# Prerequisites: GitHub CLI (gh) installed and authenticated.
# Usage: cd /Users/brofu/workspace/ai/plugins/investigation-insight && bash setup_remote.sh

REPO_NAME="investigation-insight"
GITHUB_USER="brofu"

echo "Setting up private remote repo for $REPO_NAME..."

# 1. Stage any uncommitted changes
git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: stage local changes before remote push"
fi

# 2. Create private GitHub repo and push
echo ""
echo "Creating private GitHub repo and pushing..."
gh repo create $REPO_NAME --private --source=. --remote=origin --push

echo ""
echo "Done! Repo is live at: https://github.com/$GITHUB_USER/$REPO_NAME"
