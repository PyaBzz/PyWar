del 01-BazWar.iwd

powershell compress-archive .\BazWar\* .\BazWar.zip

ren BazWar.zip 01-BazWar.iwd

start "RunIt" /D "..\..\" "03-Run-BazWar.bat"

REM pause