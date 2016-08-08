#!/bin/bash
##################
#Application Prerequisites
#github
#aha
#testssl.sh
#cipherscan
##################
#USAGE
#Syntax
#script.sh <ipaddress:port> <opensslcheck y/n>
#Example
#script.sh "192.168.1.0/24"
#
echo $1
echo $2
ip=$1
Opensslcheck=$2
ipaddr=$(echo "$ip" | cut -d ":" -f1)
port=$(echo "$ip" | cut -d ":" -f2)
echo $ipaddr
echo $port
#Check if conducting new nmap scan or using existing scan
tput setaf 6 ; echo "Testing $ip"
if [ $2 == "y" ]
then
	tput setaf 1 ; echo "Running OPENSSL sanity check"
	echo "x"| timeout 3 openssl s_client -showcerts -connect $ip < /dev/null &> /dev/null
	if [ $? -eq 1 ]
	then
		tput setaf 1 ; echo "Running tests on $ipaddr:$port"
		echo "<h1>$ipaddr:$port</h1>" > Results/SSL/SSL_Results_$ipaddr:$port.html &&
		echo "<h2>testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port</h2>" >> Results/SSL/SSL_Results_$ipaddr:$port.html &&
		SSLTest/testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port | aha >> Results/SSL/SSL_Results_$ipaddr:$port.html && 
		echo "<h2>cipherscan --curves --sigalg $ipaddr:$port</h2>" >> Results/SSL/SSL_Results_$ipaddr:$port.html && 
		Cipherscan/cipherscan --curves --sigalg $ipaddr:$port 2> /dev/null | aha >> Results/SSL/SSL_Results_$ipaddr:$port.html &&
		echo "<h2>o-saft.pl +vulns --ignore-no-conn --no-cert --no-dns --no-http --no-openssl --no-sni --no-warning --no-hint --no-header $ipaddr:$port</h2>" >> /root/Project/Results/SSL/SSL_Results_$ipaddr:$port.html &&
		/root/Downloads/Osaft/o-saft.pl +vulns --ignore-no-conn --no-cert --no-dns --no-http --no-openssl --no-sni --no-warning --no-hint --no-header  $ipaddr:$port 2>/dev/null | grep "Lucky" | aha >> /root/Project/Results/SSL/SSL_Results_$ipaddr:$port.html
	fi

else
        tput setaf 1 ; echo "Running tests on $ip , Skipped OPENSSL sanity check"
		echo "<h1>$ipaddr:$port</h1>" > Results/SSL/SSL_Results_$ipaddr:$port.html &&
		echo "<h2>testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port</h2>" >> Results/SSL/SSL_Results_$ipaddr:$port.html &&
		SSLTest/testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port | aha >> Results/SSL/SSL_Results_$ipaddr:$port.html && 
		echo "<h2>cipherscan --curves --sigalg $ipaddr:$port</h2>" >> Results/SSL/SSL_Results_$ipaddr:$port.html && 
		Cipherscan/cipherscan --curves --sigalg $ipaddr:$port 2> /dev/null | aha >> Results/SSL/SSL_Results_$ipaddr:$port.html &&
		echo "<h2>o-saft.pl +vulns --ignore-no-conn --no-cert --no-dns --no-http --no-openssl --no-sni --no-warning --no-hint --no-header $ipaddr:$port</h2>" >> /root/Project/Results/SSL/SSL_Results_$ipaddr:$port.html &&
		/root/Downloads/Osaft/o-saft.pl +vulns --ignore-no-conn --no-cert --no-dns --no-http --no-openssl --no-sni --no-warning --no-hint --no-header  $ipaddr:$port 2>/dev/null | grep "Lucky" | aha >> /root/Project/Results/SSL/SSL_Results_$ipaddr:$port.html
fi
