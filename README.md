# SSLEnum
##Version
v0.0.2

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
----
####Testssl_direct

**Syntax:**

```
testssl_direct <ipaddress:port> <Skip SSL connectivity check y/n>
```

**Example:**

```
testssl_direct 192.168.0.1 n
```
----

####Testssl_fromnmap

**Syntax:**

```
testssl_fromnmap <nmapxmloutput_Location> <IP range for nmap> <nmap csv output location> <new scan or leave blank if old>
```

**Example:**

```
testssl_fromnmap "/home/nmap_scan.xml" "192.168.1.0/24" "/home/nmap_output.csv" "new"
```
----

####Testssh_direct

**Syntax:**

```
testssh_direct <IPAddress>:<port>
```

**Example:**

```
testssh_direct "192.168.1.0:22"
```
