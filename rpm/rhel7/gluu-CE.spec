%global __os_install_post %{nil}
%define gluu_root /opt/gluu-server

Name: gluu-server-4.0
Version: 1
Release: 1.rhel7
Summary: Gluu Server
Group: Gluu
License: MIT
Vendor: Gluu, Inc.
Packager: Gluu support <support@gluu.org>
Source0: gluu-server.tar.gz
Source1: gluu-serverd-4.0
Source2: systemd-unitfile
AutoReqProv: no
Requires: tar, sed, openssh, coreutils >= 8.22-12, systemd >= 208-20, initscripts >= 9.49.24-1

%description
Enterprise ready, free open source software for identity & access management (IAM).

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/opt
tar -xzf %{SOURCE0} -C %{buildroot}/opt
touch "%{buildroot}%{gluu_root}/tmp/system_user.list"
touch "%{buildroot}%{gluu_root}/tmp/system_group.list"
chmod 4777 "%{buildroot}%{gluu_root}/tmp"
chmod 0755 "%{buildroot}%{gluu_root}/tmp/system_user.list"
chmod 0755 "%{buildroot}%{gluu_root}/tmp/system_group.list"
# gluu-serverd-4.0
mkdir -p %{buildroot}/usr/sbin/
/bin/cp %{SOURCE1} %{buildroot}/usr/sbin/
# systemd unit file
mkdir -p %{buildroot}/lib/systemd/system/
/bin/cp %{SOURCE2} %{buildroot}/lib/systemd/system/systemd-nspawn@gluu_server_4.0.service

%post
/usr/sbin/chroot %{gluu_root} bash -c '
/tmp/system_user.list &>/dev/null
/tmp/system_group.list &>/dev/null 
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU &>/dev/null'
# systemd-nspawn container and keys
sed -i 's/.*Storage.*/Storage=persistent/g' /etc/systemd/journald.conf
systemctl restart systemd-journald
if [[ ! -d /var/lib/container ]]; then
  mkdir -p /var/lib/container
fi
ln -s %{gluu_root} /var/lib/container/gluu_server_4.0
if [[ -d /etc/gluu/keys ]]; then
  rm -rf /etc/gluu/keys
  mkdir -p /etc/gluu/keys
else
  mkdir -p /etc/gluu/keys
fi
ssh-keygen -b 2048 -t rsa -f /etc/gluu/keys/gluu-console -q -N ""
if [[ ! -d /opt/gluu-server/root/.ssh ]]; then
  mkdir -p /opt/gluu-server/root/.ssh
  chmod 700 /opt/gluu-server/root/.ssh
fi
cat /etc/gluu/keys/gluu-console.pub > /opt/gluu-server/root/.ssh/authorized_keys
chmod 600 /opt/gluu-server/root/.ssh/authorized_keys
cp -a /etc/resolv.conf /opt/gluu-server/etc/
systemctl enable machines.target
systemctl enable systemd-nspawn@gluu_server_4.0.service

%preun
echo "Stopping Gluu Server ..."
systemctl stop systemd-nspawn@gluu_server_4.0.service
systemctl disable machines.target

%postun
if [ -d %{gluu_root}.rpm.saved ] ; then
        rm -rf %{gluu_root}.rpm.saved
fi
/bin/mv %{gluu_root} %{gluu_root}.rpm.saved
echo "Your changes will be saved into %{gluu_root}.rpm.saved"
rm -rf /etc/gluu/keys
unlink /var/lib/container/gluu_server_4.0
rm -rf /var/lib/container/gluu_server_4.0
rm -rf /opt/gluu-server

%files
%{gluu_root}/*
%attr(755,root,root) /usr/sbin/gluu-serverd-4.0
/lib/systemd/system/systemd-nspawn@gluu_server_4.0.service

%clean
rm -rf %{buildroot}

%changelog
* Wed Jan 13 2016 Adrian Alves <adrian@gluu.org> - 1-1
- new release 4.0
