#!/bin/bash
VERSION=`cat gluu-CE.spec | grep -w "Release:" | awk {'print $2'} | awk -F "." {'print $1'}`
NEW_VERSION=$(($VERSION + 1))
sed -i "s/Release: $VERSION.rhel7/Release: $NEW_VERSION.rhel7/g" gluu-CE.spec
