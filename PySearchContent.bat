echo off
cls
set _keyword=

:getKeyword
set /p _keyword=Enter search keyword:
if [%_keyword%]==[] goto getKeyword

:getCaseSensitive
set _caseSwitch=/i
set _caseInput=
set _caseMessage=INSENSITIVE
set /p _caseInput=Case sensitive [y/n  default n]:
if /i "%_caseInput:~,1%"=="y" (
set _caseSwitch=
set _caseMessage=SENSITIVE
)

:getFileExtension
set _fileExtension=*
set _fileExtensionInput=
set /p _fileExtensionInput=Target file extension [default *]:

REM TODO: Change all variable decalations to local!

REM TODO: Remove "." from the input
set _fileExtensionInput=%_fileExtensionInput:.=X%
if [%_fileExtensionInput%]!=[] set _fileExtension=_fileExtensionInput


cls
echo ============================  PySearch  ============================
echo ============================  PySearch  ============================ > PySearchResult.txt
echo Content search case %_caseMessage% for:  %_keyword%
echo Content search case %_caseMessage% for: >> PySearchResult.txt
echo %_keyword% >> PySearchResult.txt
echo Command:  findstr /s %_caseSwitch% "%_keyword%" *.%_fileExtension%
echo Command: >> PySearchResult.txt
echo findstr /s %_caseSwitch% "%_keyword%" *.%_fileExtension% >> PySearchResult.txt
echo Output file: PySearchResult.txt
echo ==============================  Done  ==============================
echo =============================  Result  ============================= >> PySearchResult.txt
echo.
echo. >> PySearchResult.txt

findstr /s %_caseSwitch% "%_keyword%" *.%_fileExtension% >> PySearchResult.txt

REM TODO: Make the output file automatically pop open.


REM =====================  Clean up  =====================

set "_caseMessage="
set "_keyword="
set "_caseSwitch="
set "_caseInput="
set "_caseMessage="
set "_fileExtension="
set "_result="

pause