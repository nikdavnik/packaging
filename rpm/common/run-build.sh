#!/bin/bash

VERSION=$(echo "%VERSION%" | awk -F '-' {'print $1'})
REL=$(echo "%VERSION%" | cut -d'-' -f 2-)
current_dir=`pwd`
sed -i "s/%VER%/$VERSION/g" *.spec
sed -i "s/%REL%/$REL/g" *.spec
rpmbuild_path="$current_dir/rpmbuild"
mkdir -p $rpmbuild_path/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
cp $current_dir/*.spec $rpmbuild_path/SPECS/.
mv jans-src jans-$VERSION
tar cvfz jans-$VERSION.tar.gz jans-$VERSION
cp jans-$VERSION.tar.gz $rpmbuild_path/SOURCES/.

specfile=jans-el8.spec
rpmbuild -bb --define "_topdir $rpmbuild_path" $rpmbuild_path/SPECS/$specfile
specfile=jans-suse15.spec
rpmbuild -bb --define "_topdir $rpmbuild_path" $rpmbuild_path/SPECS/$specfile
