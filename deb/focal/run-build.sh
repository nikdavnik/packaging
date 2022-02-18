#!/bin/bash
VERION=%VERSION%
sed -i "s/%VERSION%/$VERSION/g" ../debian/changelog
cd jans-src
tar cvfz ../jans_%VERSION%.tar.gz *
cp -a ../debian .
tar cvfz ../jans_%VERSION%.orig.tar.gz *
debuild -us -uc
cd ..
