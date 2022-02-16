#!/bin/bash

tar cvfz jans_1.0.0.tar.gz jans-1.0.0/*
cp -a debian jans-1.0.0/
tar cvfz jans_1.0.0.orig.tar.gz jans-1.0.0/*
debuild -us -uc
cd ..
