#!/bin/bash

VERSION=$(echo "%VERSION%" | awk -F '-' {'print $1'})
REL=$(echo "%VERSION%" | cut -d'-' -f 2-)
current_dir=`pwd`
sed -i "s/%VER%/$VERSION/g" jans.spec
sed -i "s/%REL%/$REL/g" jans.spec
rpmbuild_path="$current_dir/rpmbuild"
mkdir -p $rpmbuild_path/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
specfile=jans.spec
cp $current_dir/$specfile $rpmbuild_path/SPECS/.
mv jans-src jans-$VERSION
tar cvfz jans-$VERSION.tar.gz jans-$VERSION
cp jans-$VERSION.tar.gz $rpmbuild_path/SOURCES/.
rm -rf rpmbuild/RPMS/x86_64/*
rpmbuild -bb --define "_topdir $rpmbuild_path" $rpmbuild_path/SPECS/$specfile
rpm --addsign rpmbuild/RPMS/x86_64/jans-$VERSION-$REL.suse15.x86_64.rpm
sha256sum rpmbuild/RPMS/x86_64/jans-$VERSION-$REL.suse15.x86_64.rpm > rpmbuild/RPMS/x86_64/jans-$VERSION-$REL.suse15.x86_64.rpm.sha256sum
