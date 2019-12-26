#!/bin/bash

VER=$1
INSTALL_VER=$2

DIRWEB="gluu-server.amd64/gluu-server/opt/dist/gluu"
COMMUNITY="gluu-server.amd64/gluu-server/install"

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
    
    #rm -rf $COMMUNITY/community-edition-setup*
    #curl -LkSs https://codeload.github.com/GluuFederation/community-edition-setup/zip/$INSTALL -o $COMMUNITY/community-edition-setup.zip
    #unzip $COMMUNITY/community-edition-setup.zip -d $COMMUNITY
    #mv -nv $COMMUNITY/community-edition-setup-$INSTALL $COMMUNITY/community-edition-setup
    #rm -rf $COMMUNITY/community-edition-setup.zip
    wget -nv https://github.com/GluuFederation/community-edition-setup/archive/$INSTALL.zip -O $DIRWEB/community-edition-setup.zip
    wget -nv https://raw.githubusercontent.com/GluuFederation/community-edition-setup/master/install.py -O gluu-server.amd64/gluu-server/opt/gluu/bin/install.py
    chmod +x gluu-server.amd64/gluu-server/opt/gluu/bin/install.py
    
    wget https://ox.gluu.org/npm/passport/passport-4.1.0.tgz -O $DIRWEB/passport.tgz
    wget https://ox.gluu.org/npm/passport/passport-$INSTALL-node_modules.tar.gz -O $DIRWEB/passport-$INSTALL-node_modules.tar.gz
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/gluu-serverd -O gluu-server.amd64/gluu-server/tmp/gluu-serverd
    chmod +x gluu-server.amd64/gluu-server/tmp/gluu-serverd
    wget -nv https://ox.gluu.org/maven/org/gluu/super-gluu-radius-server/$VER/super-gluu-radius-server-$VER-distribution.zip -O $DIRWEB/gluu-radius-libs.zip
    wget -nv https://ox.gluu.org/maven/org/gluu/super-gluu-radius-server/$VER/super-gluu-radius-server-$VER.jar -O $DIRWEB/super-gluu-radius-server.jar
    
    # systemd files for services
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/identity.service -O gluu-server.amd64/gluu-server/lib/systemd/system/identity.service 
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/opendj.service -O gluu-server.amd64/gluu-server/lib/systemd/system/opendj.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/oxauth-rp.service -O gluu-server.amd64/gluu-server/lib/systemd/system/oxauth-rp.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/oxauth.service -O gluu-server.amd64/gluu-server/lib/systemd/system/oxauth.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/passport.service -O gluu-server.amd64/gluu-server/lib/systemd/system/passport.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/idp.service -O gluu-server.amd64/gluu-server/lib/systemd/system/idp.service
    
    # Update script
    mkdir -p gluu-server.amd64/gluu-server/install/update
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/master/update/4.0.x/update_4.0.1.py -O gluu-server.amd64/gluu-server/install/update/update_4.0.1.py
    chmod +x gluu-server.amd64/gluu-server/install/update/update_4.0.1.py    
fi
