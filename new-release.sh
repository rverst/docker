#!/bin/bash

set -eou pipefail

release="$1"

sed -i.bak "s/ENV release=.*/ENV release=\"$release\"/" Dockerfile
rm -f Dockerfile.bak
git add Dockerfile
git checkout -b "$release"
git commit -m "Updated for release $release"
git tag -a -m "Release $release" "$release"

