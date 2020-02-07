del 01-PyGunGame.iwd

powershell compress-archive .\PyGunGame\* .\PyGunGame.zip

ren PyGunGame.zip 01-PyGunGame.iwd

start "RunIt" /D "..\..\" "01-Run-PyGunGame.bat"

REM pause