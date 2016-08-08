#!/bin/bash
##################
#Application Prerequisites
#github
#SSH
#aha
#nmap
##################
#USAGE
#Syntax
#script.sh <ipaddress:port>
#Example
#script.sh "192.168.1.0:22"
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
tput setaf 1 ; echo "Running tests on $ipaddr:$port"
echo "<h1>$ipaddr:$port</h1>" > Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h2>Login Banner</h2>" >> Results/SSH/SSH_Results_$ipaddr:$port.html && 
echo "<h3>ssh -vvv -oBatchMode=yes $ipaddr 2>&1 | sed -n -e '/input_userauth_banner/,/debug3/p'</h3>" >> Results/SSH/SSH_Results_$ipaddr:$port.html && 
tput setaf 2 ; echo "Checking User Authentication banner"
ssh -vvv -oBatchMode=yes $ipaddr 2>&1 | sed -n -e '/input_userauth_banner/,/debug3/p' | aha >> Results/SSH/SSH_Results_$ipaddr:$port.html && 
echo "<h2>Authentication Methods</h2>" >> Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h3>ssh -o BatchMode=yes $ipaddr</h3>" >> Results/SSH/SSH_Results_$ipaddr:$port.html &&
tput setaf 2 ; echo "Checking User Authentication Modes"
ssh -o BatchMode=yes $ipaddr 2>&1 | grep password | aha >> Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h2>Encryption information</h2>" >> Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h3>nmap $ipaddr:$port</h3>" >> Results/SSH/SSH_Results_$ipaddr:$port.html &&
tput setaf 2 ; echo "Checking SSH algorithms and hostkey"
nmap -p $port --script ssh2-enum-algos,ssh-hostkey --script-args ssh_hostkey=all $ipaddr | aha >> Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "Completed Scan....Results saved to $($path)/Results/SSH/SSH_Results_$ipaddr:$port.html"