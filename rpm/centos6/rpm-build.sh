#!/bin/bash

# Define pathes
current_dir=`pwd`
gluu_ce_path="$current_dir"
rpmbuild_path="$current_dir/rpmbuild"
./clean-prebuild.sh
# Prepare build folders
mkdir -p $rpmbuild_path/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

# Spec file name
specfile=gluu-CE.spec

# Prepare sources
cd $gluu_ce_path

/bin/tar czvf gluu-server-4.0.tar.gz --exclude=".gitignore" gluu-server-4.0
/bin/mv gluu-server-4.0.tar.gz $rpmbuild_path/SOURCES/
/bin/cp gluu-server-init-script $rpmbuild_path/SOURCES/
/bin/cp profile $rpmbuild_path/SOURCES/
/bin/cp $specfile $rpmbuild_path/SPECS/

# Run build
rpmbuild -ba --define "_topdir $rpmbuild_path" $rpmbuild_path/SPECS/$specfile
#rpmbuild -ba --define "_topdir $rpmbuild_path" --define "%_signature gpg" --define "%_gpg_path /root/.gnupg" --define "%_gpg_name Gluu.org (Key for gluu centos repo) <support@gluu.org>" --define "%_gpgbin /usr/bin/gpg" --sign $rpmbuild_path/SPECS/$specfile
