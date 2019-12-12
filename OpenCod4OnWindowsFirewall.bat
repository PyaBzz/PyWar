echo off
cls

echo Opening TCP 28960,8283

netsh advfirewall firewall add rule name="PyCod4Tcp" dir=in action=allow protocol=TCP localport=28960,8283

echo Opening UDP 28960,8283

netsh advfirewall firewall add rule name="PyCod4Udp" dir=in action=allow protocol=UDP localport=28960,8283

pause