#!/bin/bash

VER=$1
INSTALL_VER=$2

DIRWEB="gluu-server.amd64/gluu-server-vip-4.0/opt/dist/gluu"
COMMUNITY="gluu-server.amd64/gluu-server-vip-4.0/install"

INSTALL="master"
if [ -n "${INSTALL_VER}" ]; then
    INSTALL=$INSTALL_VER
fi

if [ -n "${VER}" ]; then
    wget -nv http://ox.gluu.org/maven/org/gluu/oxshibbolethIdp/$VER/oxshibbolethIdp-$VER.war -O $DIRWEB/idp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxtrust-server/$VER/oxtrust-server-$VER.war -O $DIRWEB/identity.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxauth-server/$VER/oxauth-server-$VER.war -O $DIRWEB/oxauth.war
    #wget -nv http://ox.gluu.org/maven/org/gluu/oxauth-rp/$VER/oxauth-rp-$VER.war -O $DIRWEB/oxauth-rp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxShibbolethStatic/$VER/oxShibbolethStatic-$VER.jar -O $DIRWEB/shibboleth-idp.jar
    wget -nv http://ox.gluu.org/maven/org/gluu/oxShibbolethKeyGenerator/$VER/oxShibbolethKeyGenerator-$VER.jar -O $DIRWEB/idp3_cml_keygenerator.jar
    rm -rf $COMMUNITY/community-edition-setup*
    curl -LkSs https://codeload.github.com/GluuFederation/community-edition-setup/zip/$INSTALL -o $COMMUNITY/community-edition-setup.zip
    unzip $COMMUNITY/community-edition-setup.zip -d $COMMUNITY
    mv -nv $COMMUNITY/community-edition-setup-$INSTALL $COMMUNITY/community-edition-setup
    rm -rf $COMMUNITY/community-edition-setup.zip
    wget https://ox.gluu.org/npm/passport/passport-4.0.0.tgz -O $DIRWEB/passport.tgz
    wget https://ox.gluu.org/npm/passport/passport-master-node_modules.tar.gz -O $DIRWEB/passport-master-node_modules.tar.gz
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/gluu-serverd -O gluu-server.amd64/gluu-server-vip-4.0/tmp/gluu-serverd-4.0
    chmod +x gluu-server.amd64/gluu-server-vip-4.0/tmp/gluu-serverd-4.0
   
    mkdir -p gluu-server.amd64/gluu-server-vip-4.0/opt/couchbase/
    wget https://packages.couchbase.com/releases/6.0.1/couchbase-server-enterprise_6.0.1-ubuntu18.04_amd64.deb -O gluu-server.amd64/gluu-server-vip-4.0/opt/couchbase/couchbase-server-enterprise_6.0.1-ubuntu18.04_amd64.deb
fi
