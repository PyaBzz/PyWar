echo off
cls

echo Opening TCP 8283 for fast download from IIS

netsh advfirewall firewall add rule name="BazWarCod4Tcp" dir=in action=allow protocol=TCP localport=8283

echo Opening UDP 28960,20800,20810 for the game

netsh advfirewall firewall add rule name="BazWarCod4Udp" dir=in action=allow protocol=UDP localport=28960,20800,20810

pause