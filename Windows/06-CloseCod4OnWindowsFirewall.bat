echo off
cls

echo Deleting FW rules corresponding to CoD4 and IIS downloads

netsh advfirewall firewall delete rule name="BazWarCod4Tcp"

netsh advfirewall firewall delete rule name="BazWarCod4Udp"

pause
