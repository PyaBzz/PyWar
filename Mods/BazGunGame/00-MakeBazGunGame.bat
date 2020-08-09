del 01-BazGunGame.iwd

powershell compress-archive .\BazGunGame\* .\BazGunGame.zip

ren BazGunGame.zip 01-BazGunGame.iwd

start "RunIt" /D "..\..\" "01-Run-BazGunGame.bat"

REM pause