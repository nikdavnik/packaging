#!/bin/bash

cd jans-1.0.0
tar cvfz ../jans_%VERSION%.tar.gz *
cp -a ../debian .
tar cvfz ../jans_%VERSION%.orig.tar.gz *
debuild -us -uc
cd ..
