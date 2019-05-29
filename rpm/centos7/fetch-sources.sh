#!/bin/bash

build_root="./gluu-server"

VER=$1
INSTALL_VER=$2

DISTWEB="gluu-server-4.0/opt/dist/gluu"
COMMUNITY="gluu-server-4.0/install"

INSTALL="master"
if [ -n "${INSTALL_VER}" ]; then
    INSTALL=$INSTALL_VER
fi

if [ -n "${VER}" ]; then
    #wget -nv http://ox.gluu.org/maven/org/gluu/oxidp/$VER/oxidp-$VER.war -O $DISTWEB/idp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxshibbolethIdp/$VER/oxshibbolethIdp-$VER.war -O $DISTWEB/idp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxtrust-server/$VER/oxtrust-server-$VER.war -O $DISTWEB/identity.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxauth-server/$VER/oxauth-server-$VER.war -O $DISTWEB/oxauth.war
    #wget -nv http://ox.gluu.org/maven/org/gluu/oxauth-rp/$VER/oxauth-rp-$VER.war -O $DIRWEB/oxauth-rp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxShibbolethStatic/$VER/oxShibbolethStatic-$VER.jar -O $DISTWEB/shibboleth-idp.jar
    wget -nv http://ox.gluu.org/maven/org/gluu/oxShibbolethKeyGenerator/$VER/oxShibbolethKeyGenerator-$VER.jar -O $DISTWEB/idp3_cml_keygenerator.jar
#    wget -nv http://ox.gluu.org/maven/org/gluu/credmgr/credmgr/$VER/credmgr-$VER.war -O $DISTWEB/credmgr.war
    rm -rf $COMMUNITY/community-edition-setup*
    curl -LkSs https://codeload.github.com/GluuFederation/community-edition-setup/zip/$INSTALL -o $COMMUNITY/community-edition-setup.zip
    unzip $COMMUNITY/community-edition-setup.zip -d $COMMUNITY
    mv $COMMUNITY/community-edition-setup-$INSTALL $COMMUNITY/community-edition-setup
    rm -rf $COMMUNITY/community-edition-setup.zip
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/initd/gluu-server -O gluu-server-init-script
    chmod +x gluu-server-init-script
    wget https://ox.gluu.org/npm/passport/passport-4.0.0.tgz -O $DISTWEB/passport.tgz
    wget https://ox.gluu.org/npm/passport/passport-master-node_modules.tar.gz -O $DISTWEB/passport-master-node_modules.tar.gz
    wget -nv http://c1.gluu.org:8999/gluu-radius.tgz -O $DIRWEB/gluu-radius.tgz

    # systemd files for services
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/identity.service -O gluu-server-4.0/lib/systemd/system/identity.service 
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/opendj.service -O gluu-server-4.0/lib/systemd/system/opendj.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/oxauth-rp.service -O gluu-server-4.0/lib/systemd/system/oxauth-rp.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/oxauth.service -O gluu-server-4.0/lib/systemd/system/oxauth.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/passport.service -O gluu-server-4.0/lib/systemd/system/passport.service

fi
