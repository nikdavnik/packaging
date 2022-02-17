#!/bin/bash

cd jans-1.0.0
tar cvfz ../jans_1.0.0.tar.gz *
cp -a ../debian .
tar cvfz ../jans_1.0.0.orig.tar.gz *
debuild -us -uc
cd ..
