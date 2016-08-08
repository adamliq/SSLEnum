# SSLEnum
##Version
v0.0.1

##Description
Scripts utilised for the vulnerability/Compliancy assessment of;
* SSL/TLS Endpoints
* RDP Endpoints
* SSH Endpoints

##Requirements
Tested on Kali Rolling 2016.1

##Tools

* SSLTest.sh
* Cipherscan
* XMLStarlet
* rdp-sec-check
* AHA (Ansi HTML Adaptor)

##Install

git clone https://github/adamliq/SSLEnum.git && cd SSLEnum && chmod +x Install.sh && ./Install.sh

##Usage
###Script
####Testssl_direct
----
**Syntax:**

```
testssl_direct <ipaddress:port> <Skip SSL connectivity check y/n>
```

**Example:**

```
testssl_direct 192.168.0.1 n
```
