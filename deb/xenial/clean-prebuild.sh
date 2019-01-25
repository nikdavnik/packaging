#!/bin/bash
rm -rf *.changes
rm -rf *.deb
rm -rf *.dsc
rm -rf *.tar.gz
pushd gluu-server.amd64
debuild clean
popd

