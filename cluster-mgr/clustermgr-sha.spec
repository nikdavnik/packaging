Name:		clustermgr-sha
Version:	%VERSION%
Release:	%RELEASE%
Summary:	OAuth protected API
License:	GUI tool for installing and managing clustered Gluu Servers 
URL:  https://www.gluu.org
Source0:	clustermgr-sha-4.2.1.tgz
Source1:	clustermgr-sha.service

%description
Cluster Manager (CM) is a GUI tool for installing and managing a highly available, 
clustered Gluu Server infrastructure on physical servers or VMs

%prep
%setup -q

%install
mkdir -p %{buildroot}/tmp/
mkdir -p %{buildroot}/opt/
mkdir -p %{buildroot}/lib/systemd/system/
cp -a %{SOURCE1} %{buildroot}/lib/systemd/system/clustermgr-sha.service
cp -a clustermgr-sha %{buildroot}/opt/

%pre
mkdir -p /opt

%post
systemctl daemon-reload > /dev/null 2>&1
systemctl enable clustermgr-sha > /dev/null 2>&1

%preun
systemctl stop clustermgr-sha > /dev/null 2>&1

%postun
if [ "$1" = 0 ]; then 
rm -rf /opt/clustermgr-sha > /dev/null 2>&1
rm -rf /lib/systemd/system/clustermgr-sha.service > /dev/null 2>&1
systemctl daemon-reload > /dev/null 2>&1
fi

%files
/opt/clustermgr-sha/*
/lib/systemd/system/clustermgr-sha.service

%changelog
* Wed Apr 29 2020 Davit Nikoghosyan <davit@gluu.org> - %VERSION%-1
- Release %VERSION%
