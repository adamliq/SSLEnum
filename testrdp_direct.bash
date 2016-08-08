#!/bin/bash
##################
#Application Prerequisites
#github
#aha
#rdp-sec-check
#testssl.sh
#cipherscan
##################
#USAGE
#Syntax
#script.sh <ipaddress:port> <opensslcheck y/n>
#Example
#script.sh "192.168.1.0:3389" "n"
#
echo $1
echo $2
ip=$1
Opensslcheck=$2
ipaddr=$(echo "$ip" | cut -d ":" -f1)
port=$(echo "$ip" | cut -d ":" -f2)
path=pwd
echo $ipaddr
echo $port
tput setaf 6 ; echo "Testing $ip"
if [ $2 == "y" ]
then
	tput setaf 1 ; echo "Running OPENSSL sanity check"
	echo "x"| timeout 3 openssl s_client -showcerts -connect $ip < /dev/null &> /dev/null
	if [ $? -eq 1 ]
	then
        tput setaf 1 ; echo "Running tests on $ipaddr:$port"
		echo "<h1>$ipaddr:$port</h1>" > Results/RDP/RDP_Results_$ipaddr:$port.html &&
		echo "<h2>testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html &&
		tput setaf 2 ; echo "Running TESTSSL.SH"		
		SSLTest/testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
		echo "<h2>cipherscan --curves --sigalg $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
		tput setaf 2 ; echo "Running CIPHERSCAN"
		Cipherscan/cipherscan --curves --sigalg $ipaddr:$port 2> /dev/null | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
		echo "<h2>rdp-sec-check.pl $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html &&
		tput setaf 2 ; echo "Running RDP-SEC-CHECK"
		rdpseccheck/rdp-sec-check.pl $ipaddr:$port | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html
	fi

else
        tput setaf 1 ; echo "Running tests on $ipaddr:$port"
		echo "<h1>$ipaddr:$port</h1>" > Results/RDP/RDP_Results_$ipaddr:$port.html &&
		echo "<h2>testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html &&
		tput setaf 2 ; echo "Running TESTSSL.SH"		
		SSLTest/testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
		echo "<h2>cipherscan --curves --sigalg $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
		tput setaf 2 ; echo "Running CIPHERSCAN"
		Cipherscan/cipherscan --curves --sigalg $ipaddr:$port 2> /dev/null | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
		echo "<h2>rdp-sec-check.pl $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html &&
		tput setaf 2 ; echo "Running RDP-SEC-CHECK"
		rdpseccheck/rdp-sec-check.pl $ipaddr:$port | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html
fi
