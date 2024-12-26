@echo off
:init
setlocal DisableDelayedExpansion
title Link Creator
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~dpnx0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO Invoking UAC for Privilege Escalation
ECHO.

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
if '%cmdInvoke%'=='1' goto InvokeCmd 
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:start
title Link Creator
echo Welcome to the link creator
echo ==========V 1.0==========
echo 1=Symlink
echo 2=Junction
echo 3=Hardlink
set /p linktype=What link would you like to create?-
if %linktype%==1 goto symlink
if %linktype%==2 goto junction
if %linktype%==3 goto hardlink
if %linktype%==SymLink goto symlink
if %linktype%==Junction goto junction
if %linktype%==HardLink goto hardlink
if %linktype%==Symlink goto symlink
if %linktype%==Hardlink goto hardlink
if %linktype%==symlink goto symlink
if %linktype%==hardlink goto hardlink
if %linktype%==junction goto junction
:symlink
echo 1=Yes
echo 2=No
set /p dir=Is your symlink for a directory?-
if %dir%==y set dir=/d
if %dir%==1 set dir=/d
if %dir%==Y set dir=/d
if %dir%==n set dir= 
if %dir%==2 set dir= 
if %dir%==N set dir= 
set /p from=Enter the from location for your symlink(No quotation marks)-
set from="%from%"
set /p to=Enter where you want your symlink to go to(No quotation marks)-
set to="%to%"
echo Creating Link...
mklink %dir% %from% %to%
echo Done!
echo 1=Yes
echo 2=No
set /p another=Would you like to create another link?-
if %another%==1 cls && goto start
if %another%==y cls && goto start
if %another%==Y cls && goto start
if %another%==2 cls && goto end
if %another%==n cls && goto end
if %another%==N cls && goto end
pause
:junction
set /p from=Enter the from location for your junction(No quotation marks)-
set from="%from%"
set /p to=Enter where you want your junction to go to(No quotation marks)-
set to="%to%"
echo Creating Link...
mklink /j %from% %to%
echo Done!
echo 1=Yes
echo 2=No
set /p another=Would you like to create another link?-
if %another%==1 cls && goto start
if %another%==y cls && goto start
if %another%==Y cls && goto start
if %another%==2 cls && goto end
if %another%==n cls && goto end
if %another%==N cls && goto end
:hardlink
set /p from=Enter the from location for your hardlink(No quotation marks)-
set from="%from%"
set /p to=Enter where you want your hardlink to go to(No quotation marks)-
set to="%to%"
echo Creating Link...
mklink /h %from% %to%
echo Done!
echo 1=Yes
echo 2=No
set /p another=Would you like to create another link?-
if %another%==1 cls && goto start
if %another%==y cls && goto start
if %another%==Y cls && goto start
if %another%==2 cls && goto start
if %another%==n cls && goto start
if %another%==N cls && goto start
:end
pause
exit