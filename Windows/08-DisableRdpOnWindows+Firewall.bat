echo off
cls

echo Disabling RDP on Windows

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

echo Blocking RDP through Firewall

netsh advfirewall firewall set rule group="remote desktop" new enable=No

pause
