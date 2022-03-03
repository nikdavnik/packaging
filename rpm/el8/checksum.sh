#!/bin/bash

VERSION=$(echo "%VERSION%" | awk -F '-' {'print $1'})
REL=$(echo "%VERSION%" | cut -d'-' -f 2-)
sha256sum rpmbuild/RPMS/x86_64/jans-$VERSION-$REL.el8.x86_64.rpm > rpmbuild/RPMS/x86_64/jans-$VERSION-$REL.el8.x86_64.rpm.sha256sum
