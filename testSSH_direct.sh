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
tput setaf 1 ; echo "Running tests on $ipaddr:$port"
echo "<h1>$ipaddr:$port</h1>" > /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h2>Login Banner</h2>" >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html && 
echo "<h3>ssh -vvv -oBatchMode=yes $ipaddr 2>&1 | sed -n -e '/input_userauth_banner/,/debug3/p'</h3>" >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html && 
ssh -vvv -oBatchMode=yes $ipaddr 2>&1 | sed -n -e '/input_userauth_banner/,/debug3/p' | aha >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html && 
echo "<h2>Authentication Methods</h2>" >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h3>ssh -o BatchMode=yes $ipaddr</h3>" >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html &&
ssh -o BatchMode=yes $ipaddr 2>&1 | grep password | aha >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h2>Encryption information</h2>" >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html &&
echo "<h3>nmap $ipaddr:$port</h3>" >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html &&
nmap -p $port --script ssh2-enum-algos,ssh-hostkey --script-args ssh_hostkey=all $ipaddr | aha >> /root/Project/Results/SSH/SSH_Results_$ipaddr:$port.html
