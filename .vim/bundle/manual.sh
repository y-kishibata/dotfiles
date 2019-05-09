#!/bin/sh

cd manual

## swift-lint
git clone git@github.com:apple/swift.git apple-swift
pushd apple-swift
git filter-branch --subdirectory-filter utils/vim HEAD
rm -rf .git
popd
