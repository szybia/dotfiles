#!/bin/bash

set -ex

# Clear npm cache
echo "Clearing npm cache..."
npm cache clean --force

# Remove globally installed npm packages
echo "Removing globally installed npm packages..."
npm list -g --depth=0 | awk '/\// {print $2}' | cut -d@ -f1 | xargs npm uninstall -g

# Remove npm's cache directory
echo "Removing npm's cache directory..."
rm -rf ~/.npm

echo "NPM environment has been cleaned."
