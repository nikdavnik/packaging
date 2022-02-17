#!/bin/bash
cd jans-%VERSION%

current_dir=`pwd`
rpmbuild_path="$current_dir/rpmbuild"
mkdir -p $rpmbuild_path/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
specfile=jans.spec
cp $current_dir/$specfile $rpmbuild_path/SPECS/.
tar cvfz jans-%VERSION%.tar.gz jans-%VERSION%
cp jans-%VERSION%.tar.gz $rpmbuild_path/SOURCES/.
rm -rf rpmbuild/RPMS/x86_64/*
rpmbuild -bb --define "_topdir $rpmbuild_path" $rpmbuild_path/SPECS/$specfile

