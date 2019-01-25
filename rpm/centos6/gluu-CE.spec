%define __os_install_post %{nil}

Name: gluu-server-3.1.5
Version: 1
Release: 15.centos6
Summary: Gluu chroot CE environment
Group: Gluu
Requires: tar, net-tools
AutoReqProv: no
License: GLUU License
Vendor: Gluu, Inc.
Packager: Gluu support <support@gluu.org>
Source0: gluu-server-3.1.5.tar.gz
Source1: gluu-server-init-script
%description
Gluu base deployment for CE


%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/etc/init.d
mkdir -p %{buildroot}/opt
tar -xzf %{SOURCE0} -C %{buildroot}/opt
/bin/cp %{SOURCE1} %{buildroot}/etc/init.d/gluu-server-3.1.5

%post
/sbin/chkconfig ip6tables off > /dev/null 2>&1
/sbin/service ip6tables stop > /dev/null 2>&1
/sbin/chkconfig postfix off > /dev/null 2>&1
/sbin/service postfix stop > /dev/null 2>&1
/usr/sbin/chroot /opt/gluu-server-3.1.5 /bin/su - root -c '/tmp/system_user.list' > /dev/null 2>&1
/usr/sbin/chroot /opt/gluu-server-3.1.5 /bin/su - root -c '/tmp/system_group.list' > /dev/null 2>&1
/usr/sbin/chroot /opt/gluu-server-3.1.5 /bin/su - root -c 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU' > /dev/null 2>&1
/sbin/chkconfig --add gluu-server-3.1.5
/sbin/chkconfig gluu-server-3.1.5 on
/bin/cp -a /etc/resolv.conf /opt/gluu-server-3.1.5/etc/

%preun
echo "Checking if Gluu Server isn't running..."
/sbin/service gluu-server-3.1.5 stop > /dev/null 2>&1

/sbin/chkconfig --del gluu-server-3.1.5
STAT=(`df -aP |grep gluu | awk '{ print $6 }' | grep -Eohw 'proc|lo|pts|modules|dev' |sort -u`)
if [ "$STAT" != "" ]; then
	echo "Couldn't unmount chroot container of gluu-server-3.1.5,  please unmount manually, before uninstall"
	exit 2
fi

%postun
/sbin/chkconfig postfix on > /dev/null 2>&1
/sbin/service postfix start > /dev/null 2>&1
if [ -d /opt/gluu-server-3.1.5.rpm.saved ] ; then
	rm -rf /opt/gluu-server-3.1.5.rpm.saved
fi

/bin/mv /opt/gluu-server-3.1.5 /opt/gluu-server-3.1.5.rpm.saved
echo "Your changes will be saved into /opt/gluu-server-3.1.5.rpm.saved"

%files
/etc/init.d/gluu-server-3.1.5
/opt/gluu-server-3.1.5/*
%attr(0544,root,root) /opt/gluu-server-3.1.5/tmp/system_user.list
%attr(0544,root,root) /opt/gluu-server-3.1.5/tmp/system_group.list

%clean
rm -rf %{buildroot}

%changelog
* Thu Oct 25 2015 Adrian Alves <support@gluu.org> - 1-1
- Release 3.1.5
