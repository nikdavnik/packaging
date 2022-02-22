#!/bin/bash
VERSION=%VERSION%
sed -i "s/%VER%/$VERSION/g" debian/changelog
cd jans-src
tar cvfz ../jans_%VERSION%.tar.gz *
cp -a ../debian .
tar cvfz ../jans_%VERSION%.orig.tar.gz *
debuild -us -uc
cd ..
dpkg-sig -s builder -k 0544BA38 jans_%VERSION%~ubuntu20.04_amd64.deb 
sha256sum jans_%VERSION%~ubuntu20.04_amd64.deb > jans_%VERSION%~ubuntu20.04_amd64.deb.sha256sum
