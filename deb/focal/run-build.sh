#!/bin/bash

#rm -rf *.gz *.deb *.build* *.changes *.dsc
#rm -rf jans-1.0.0/*
#mkdir -p jans-1.0.0
#cp install.py jans-1.0.0/install.py
#cd jans-1.0.0


#python3 install.py --no-setup
rm -rf install.py
rm -rf tmp
rm -rf install
rm -rf jans-cli

touch opt/jans/jans-setup/package

tar cvfz ../jans_1.0.0.tar.gz *
cp -a ../debian .
tar cvfz ../jans_1.0.0.orig.tar.gz *
debuild -us -uc
cd ..
