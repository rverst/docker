#!/bin/bash

release="$1"

sed -i '' "s/ENV release=.*/ENV release=$release/" Dockerfile
git add Dockerfile
git commit -m "Updated for release $release"
git tag -a -m "Release $release" "$release"

