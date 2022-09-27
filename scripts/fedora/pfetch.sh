#!/usr/bin/sh

REPO_URL="https://github.com/dylanaraps/pfetch"
BUILD_DIR=`mktemp -d`

echo "$BUILD_DIR"

git clone $REPO_URL $BUILD_DIR
cd $BUILD_DIR
sudo make install
