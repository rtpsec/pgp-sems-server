#!/bin/bash
echo " "
date
echo " "
echo " "
echo "======================================="
echo "         PGP Health Check              "
echo "======================================="
echo " "
echo -n "Checking Admin WebGUI Status: ............................... "
if [ $(netstat -anp |grep 0.0.0.0 | grep LISTEN |grep 9000 | wc -l) == 0 ]
then

echo "DOWN ............. Run this command:  pgpsysconf --restart httpd"
# Command pgpsysconf --restart httpd
else
echo "UP"
echo -n "Checking Securemail webpage Status: ......................... "
if [ $(netstat -anp |grep 0.0.0.0 |grep LISTEN |grep httpd| wc -l) == 0 ]
then
echo "DOWN ............. Run this command:  pgpsysconf --restart httpd"
# Restart httpd command
else
echo "UP"
fi


fi

echo -n "Checking PGP tcp connection wrapper (pgptcpwrapper): ........ "
if [ $(netstat -anp |grep 0.0.0.0 | grep LISTEN |grep 444 | wc -l) == 0 ]
then

echo "DOWN .........................  Run this command:  pgpsysconf --restart pgptcpwrapper "
# Command pgpsysconf --restart pgptcpwrapper 
else
echo "UP"
fi

echo -n "Checking PGP Email Proxy (pgpproxyd): ....................... "
# this usually uses port 25 and 2525
if [ $(netstat -anp |grep 0.0.0.0 | grep LISTEN | grep pgpproxyd | wc -l) == 0 ]
then
echo "DOWN .........................  Run this command:  pgpsysconf --restart pgpuniversal"
# Command will go here
else
echo "UP"
fi

echo -n "Checking PGP Ignition Key Service (pgptokend): .............. "
if [ $(netstat -anp |grep 0.0.0.0 |grep pgptokend| wc -l) == 0 ]
then
echo "DOWN .........................  call the TAM"
else
echo "UP"
fi

echo -n "Checking PGP Clustering and desktop listener (pgpsyncd): .... "
if [ $(netstat -anp |grep 0.0.0.0 |grep pgpsyncd | wc -l) == 0 ]
then
echo "DOWN"
else
echo "UP"
fi

echo -n "Checking PGP LDAP Keyserver service (slapd): ................ "
if [ $(netstat -anp |grep 0.0.0.0 | grep LISTEN | grep slapd | wc -l) == 0 ]
then 
echo "DOWN"
else
echo "UP"
fi

echo -n "Checking Tomcat: ............................................ "
if [ $(netstat -anp |grep 0.0.0.0 | grep LISTEN |grep java |wc -l) == 0 ]
then
echo "DOWN"
# Command will go here
else
echo "UP"
fi

echo -n "Checking Replication Service (pgprep): ...................... "
if [ $(ps aux |grep pgprep | wc -l) == 1 ]
then
echo "DOWN"
# Run pgpsysconf --restart pgprep
else
echo "UP"
fi



# Testing Cluster Connectivity
echo " "
echo " "
echo "======================================== "
echo " Checking Connectivity to cluster nodes "
echo "======================================== "
echo " "
echo -n "[hostname1] ..."
# change these IPs to match what you're using in your cluster.
pgprepctl reachable 192.168.1.1 444
echo -n "[hostname2] ..."
pgprepctl reachable 192.168.1.2 444
echo -n "[hostname3] ..."
pgprepctl reachable 192.168.1.3 444
echo -n "[hostname4] ..."
pgprepctl reachable 192.168.1.4 444
echo -n "[hostname5] "
pgprepctl reachable 192.168.1.5 444
echo -n "[hostname6] "
pgprepctl reachable 192.168.1.6 444


echo "======================================== "
echo "            Cluster logs "
echo "======================================== "
echo " "
tail /var/log/ovid/cluster-$(date +%Y-%m-%d).log


echo " "
echo "======================================== "
echo "           System Health "
echo "======================================== "
echo " "
uptime | cut -c 39-84
echo " "
free
echo " "
df -h
echo " "
# Change these as needed for your ethernet adapters
echo -n "eth0 "
ethtool eth0 |grep detected |cut -c2-30
ifconfig eth0 |grep error
echo -n "eth1 "
ethtool eth1 |grep detected |cut -c2-30
ifconfig eth1 |grep error
echo -n "eth2 "
ethtool eth2 |grep detected |cut -c2-30
ifconfig eth2 |grep error
echo " "

echo " "
echo " "

# ---- EOF ----
