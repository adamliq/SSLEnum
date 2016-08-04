#!/bin/bash
git --version || echo "GIT not installed. Please install GIT"
apt-get install -y make
mkdir Cipherscan
mkdir SSLTest
mkdir aha
git init SSLTest
git init Cipherscan
git init aha
cd aha && git pull https://github.com/theZiz/aha.git
cd ../Cipherscan && git pull https://github.com/jvehent/cipherscan.git
cd ../SSLTest && git pull https://github.com/drwetter/testssl.sh.git
cd ../aha && make && make install