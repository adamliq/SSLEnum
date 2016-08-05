#!/bin/bash
##################
#Application Prerequisites
#github
#xmlstarlet
#aha
#nmap
#rdp-sec-check
#testssl.sh
#cipherscan
##################
#USAGE
#Syntax
#script.sh <nmapxmloutput_Location> <IP range for nmap> <nmap csv output location> <new scan or leave blank if old>
#Example
#script.sh "/home/nmap_scan.xml" "192.168.1.0/24" "/home/nmap_output.csv" "new"
##################
#Readback of entered parameters can be commented out
echo $1
echo $2
echo $3
echo $4
nmapxml=$1
iprange=$2
nmapcsv=$3
nmap_new_old=$4
nmapcsv_prefilter=$(echo "$nmapcsv" | sed 's/.csv$/_Prefilter.csv/g')
echo "$nmapxml $iprange $nmapcsv nmap_new_old $nmapcsv_prefilter"
#Check if conducting new nmap scan or using existing scan
if [ $nmap_new_old == "new" ]
then
		##Run nmap scan
        nmap -sS -sV -T4 -A -v --version-all --disable-arp-ping -oX $nmapxml $iprange
fi
#Prepare NMAP XML into csv ipaddress and port based on http
tput setaf 6 ; echo "Filtering NMAP XML"

cat $nmapxml | xmlstarlet sel -T -t -m "//state[@state='open']" -m ../../.. -v 'address[@addrtype="ipv4"]/@addr' -m hostnames/hostname -i @name -o '  (' -v @name -o ')' -b -b -b -o "," -m .. -v @portid -o ',' -v @protocol -o "," -m service -v @name -i "@tunnel='ssl'" -o 's' -b -o "," -v @product -o ' ' -v @version -v @extrainfo -b -n -| sed 's_^\([^\t ]*\)\( ([^)]*)\)\?\t\([^\t ]*\)_\1.\3\2_' |sort -n -t. >$nmapcsv_prefilter

#Filter out for RDP services
cat $nmapcsv_prefilter | grep -E 'ms-wbt-server|,3389,' | cut -f 1,2 -d "," | sed -e 's/([^()]*)//g'|tr -d ' '> "$nmapcsv"

while IFS=',' read -r f1 f2
do
	ipaddr=$(echo "$f1" | sed -e 's/^"//' -e 's/"$//')
        port=$(echo "$f2" | sed -e 's/^"//' -e 's/"$//')
        if [ $ipaddr != "host" ]
        then
                tput setaf 6 ; echo "Testing $ipaddr:$port"
                echo "x"| timeout 3 openssl s_client -showcerts -connect $ipaddr:$port < /dev/null &> /dev/null
                if [ $? -eq 0 ]
                then
                        tput setaf 1 ; echo "Running tests on $ipaddr:$port"
						echo "<h1>$ipaddr:$port</h1>" > Results/RDP/RDP_Results_$ipaddr:$port.html &&
						echo "<h2>testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
						SSLTest/testssl.sh --ssl-native -U -s -f -p -S -P -H -E --quiet $ipaddr:$port | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
						echo "<h2>cipherscan --curves --sigalg $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
						Cipherscan/cipherscan --curves --sigalg $ipaddr:$port 2> /dev/null | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html && 
						echo "<h2>rdp-sec-check.pl $ipaddr:$port</h2>" >> Results/RDP/RDP_Results_$ipaddr:$port.html &&
						rdpseccheck/rdp-sec-check.pl $ipaddr:$port | aha >> Results/RDP/RDP_Results_$ipaddr:$port.html
                fi
        fi
done < "$nmapcsv"
