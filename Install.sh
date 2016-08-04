#!/bin/bash
git --version || echo "GIT not installed. Please install GIT"
mkdir SSLEnum_Suite
mkdir SSLEnum_Suite/Cipherscan
mkdir SSLEnum_Suite/SSLTest
git init SSLEnum_Suite/SSLTest
git init SSLEnum_Suite/Cipherscan
git pull https://github.com/theZiz/aha.git
cd SSLEnum_Suite/Cipherscan && git pull https://github.com/jvehent/cipherscan.git
cd SSLEnum_Suite/SSLTest && git pull https://github.com/drwetter/testssl.sh.git