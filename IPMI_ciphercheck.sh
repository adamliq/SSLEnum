#!/bin/bash
##################
#Application Prerequisites
#ipmitool
##################
#USAGE
#Syntax
#script.sh <target>
#Example
#script.sh "192.168.0.1"
##################
ipaddress=$1
for i in {1..23}
do
	tput setaf 6; echo "Testing $i"
	tput setaf 7; ipmitool -vv -I lanplus -C $i -H $ipaddress -U test -P test user list 2>&1 | grep -E 'Error in open session response message : no matching cipher suite|Negotiated|Unsupported'|sed 's/<< //'
	if [ $i = "17" ] ; then
		tput setaf 2; echo "	ISM COMPLIANT"
	else
		tput setaf 1; echo "	NOT ISM COMPLIANT"
	fi
done
