#!/bin/bash

VERSION=$(echo "%VERSION%" | awk -F '-' {'print $1'})
REL=$(echo "%VERSION%" | sed "s/^${VERSION}//g" | sed "s/^-//g")
if [ -z "$REL" ]; then
        RELEASE="el8"
else
        RELEASE="$REL.el8"
fi
sha256sum rpmbuild/RPMS/x86_64/jans-$VERSION-$RELEASE.x86_64.rpm > rpmbuild/RPMS/x86_64/jans-$VERSION-$RELEASE.x86_64.rpm.sha256sum
