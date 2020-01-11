echo off
cls

echo Enabling RDP on Windows

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

echo Allowing RDP through Firewall

netsh advfirewall firewall set rule group="remote desktop" new enable=Yes

pause
