#!/bin/bash
git --version || echo "GIT not installed. Please install GIT"
apt-get install -y make
apt-get install -y xmlstarlet
#Create Directory structure
mkdir Cipherscan
mkdir SSLTest
mkdir aha
mkdir rdpseccheck
mkdir Results
mkdir Results/RDP
mkdir Results/SSL
#Pull required applications from GIT
git init SSLTest
git init Cipherscan
git init aha
git init rdpseccheck
cd aha && git pull https://github.com/theZiz/aha.git
cd ../Cipherscan && git pull https://github.com/jvehent/cipherscan.git
cd ../SSLTest && git pull https://github.com/drwetter/testssl.sh.git
cd ../rdpseccheck && git pull https://github.com/portcullislabs/rdp-sec-check.git
#Configure Applications
cd ../aha && make && make install
cd ../rdpseccheck && (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan Encoding::BER