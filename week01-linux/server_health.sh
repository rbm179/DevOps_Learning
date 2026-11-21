
#!/usr/bin/env bash

echo "===================================="
echo "        SERVER HEALTH REPORT"
echo "===================================="

echo
echo "HOSTNAME"
hostname

echo
echo "DATE AND TIME"
date

echo
echo "UPTIME AND CPU LOAD"
uptime

echo
echo "MEMORY"
free -h

echo
echo "DISK"
df -h

echo
echo "NETWORK - IP ADDRESSES"
ip -br addr

echo
echo "NETWORK - LISTENING TCP PORTS"
ss -lntp

echo
echo "NGINX SERVICE STATUS"
systemctl is-active nginx

echo
echo "===================================="
echo "        END OF HEALTH REPORT"
echo "===================================="