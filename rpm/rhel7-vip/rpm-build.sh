#!/bin/bash

# Define pathes
current_dir=`pwd`
gluu_ce_path="$current_dir"
rpmbuild_path="$current_dir/rpmbuild"

# Prepare build folders
mkdir -p $rpmbuild_path/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

# Spec file name
specfile=gluu-CE.spec

# Prepare sources
cd $gluu_ce_path

/bin/tar czvf gluu-server-vip.tar.gz --exclude=".gitignore" gluu-server-vip
/bin/mv gluu-server-vip.tar.gz $rpmbuild_path/SOURCES/
/bin/cp gluu-serverd-4.0 $rpmbuild_path/SOURCES/gluu-serverd-4.0
/bin/cp systemd-unitfile $rpmbuild_path/SOURCES/systemd-unitfile
/bin/cp $specfile $rpmbuild_path/SPECS/

# Run build
rpmbuild -ba --define "_topdir $rpmbuild_path" $rpmbuild_path/SPECS/$specfile
