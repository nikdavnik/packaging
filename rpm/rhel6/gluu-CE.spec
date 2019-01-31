%define __os_install_post %{nil}

Name: gluu-server-4.0
Version: 1
Release: 1.rhel6
Summary: Gluu chroot CE environment
Group: Gluu
Requires: tar
AutoReqProv: no
License: GLUU License
Vendor: Gluu, Inc.
Packager: Gluu support <support@gluu.org>
Source0: gluu-server-4.0.tar.gz
Source1: gluu-server
Source2: profile
%description
Gluu base deployment for CE


%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/etc/init.d
mkdir -p %{buildroot}/opt
tar -xzf %{SOURCE0} -C %{buildroot}/opt

/bin/cp %{SOURCE1} %{buildroot}/etc/init.d/gluu-server-4.0

%post
/usr/sbin/chroot /opt/gluu-server-4.0 /bin/su - root -c 'sh /tmp/system_user.list'  > /dev/null 2>&1
/usr/sbin/chroot /opt/gluu-server-4.0 /bin/su - root -c 'sh /tmp/system_group.list'  > /dev/null 2>&1
/usr/sbin/chroot /opt/gluu-server-4.0 /bin/su - root -c 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU' > /dev/null 2>&1
/usr/sbin/chroot /opt/gluu-server-4.0 /bin/su - root -c 'service iptables stop' > /dev/null 2>&1
/sbin/chkconfig ip6tables off > /dev/null 2>&1
/sbin/service ip6tables stop > /dev/null 2>&1
/sbin/chkconfig postfix off > /dev/null 2>&1
/sbin/service postfix stop > /dev/null 2>&1
/sbin/chkconfig --add gluu-server-4.0
/sbin/chkconfig gluu-server-4.0 on
/bin/cp -f /opt/gluu-server-4.0/tmp/profile /opt/gluu-server-4.0/etc/profile > /dev/null 2>&1
/bin/cp -a /etc/resolv.conf /opt/gluu-server-4.0/etc/

%preun
echo "Checking if Gluu Server isn't running..."
/sbin/service gluu-server-4.0 stop > /dev/null 2>&1

/sbin/chkconfig --del gluu-server-4.0
STAT=(`df -aP |grep gluu | awk '{ print $6 }' | grep -Eohw 'proc|lo|pts|modules|dev' |sort -u`)
if [ "$STAT" != "" ]; then
        echo "Couldn't unmount chroot container of gluu-server-4.0,  please unmount manually, before uninstall"
        exit 2
fi

%postun
/sbin/chkconfig postfix on > /dev/null 2>&1
/sbin/service postfix start > /dev/null 2>&1
if [ -d /opt/gluu-server-4.0.rpm.saved ] ; then
        rm -rf /opt/gluu-server-4.0.rpm.saved
fi

/bin/mv /opt/gluu-server-4.0 /opt/gluu-server-4.0.rpm.saved
echo "Your changes will be saved into /opt/gluu-server-4.0.rpm.saved"

%files
/etc/init.d/gluu-server-4.0
/opt/gluu-server-4.0/*
%attr(0544,root,root) /opt/gluu-server-4.0/tmp/system_user.list
%attr(0544,root,root) /opt/gluu-server-4.0/tmp/system_group.list

%clean
rm -rf %{buildroot}

%changelog
* Thu Oct 25 2015 Adrian Alves <support@gluu.org> - 1-1
- Release 4.0
