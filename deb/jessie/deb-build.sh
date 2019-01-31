#!/bin/bash

# Define Paths
build_root="./gluu-server.amd64"

if [ "$1" != "" ]; then
    build_root=$1
fi

chmod 544 "${build_root}/gluu-server-4.0/tmp/system_user.list"
chmod 544 "${build_root}/gluu-server-4.0/tmp/system_group.list"

# Run Build
pushd gluu-server.amd64
dpkg-buildpackage -us -uc
popd
