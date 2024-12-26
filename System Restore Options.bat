@echo off
:init
setlocal DisableDelayedExpansion
title System Restore Options
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
title System Restore Options
ECHO Welcome to the System Restore Point Creater/Deleter
echo ==========V 1.0==========
set /p option=Would You Like To Create Or Delete Or Show Details About A Restore Point?-
IF %option%==Create Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7
IF %option%==create Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7
IF %option%==CREATE Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7
IF %option%==Show vssadmin list shadows && pause
IF %option%==show vssadmin list shadows && pause
IF %option%==SHOW vssadmin list shadows && pause
IF %option%==DELETE set /p delete=What Restore Opints Would You Like To Delete?(Oldest/All)
IF %option%==delete set /p delete=What Restore Opints Would You Like To Delete?(Oldest/All)
IF %option%==Delete set /p delete=What Restore Opints Would You Like To Delete?(Oldest/All)
IF %option%==C Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7
IF %option%==c Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7
IF %option%==S vssadmin list shadows && pause
IF %option%==s vssadmin list shadows && pause
IF %option%==D set /p delete=What Restore Opints Would You Like To Delete?(Oldest/All)
IF %option%==d set /p delete=What Restore Opints Would You Like To Delete?(Oldest/All)
IF %delete%==Oldest vssadmin delete shadows /for=C: /oldest
IF %delete%==OLDEST vssadmin delete shadows /for=C: /oldest
IF %delete%==oldest vssadmin delete shadows /for=C: /oldest
IF %delete%==all vssadmin delete shadows /all
IF %delete%==All vssadmin delete shadows /all
IF %delete%==ALL vssadmin delete shadows /all
IF %delete%==O vssadmin delete shadows /for=C: /oldest
IF %delete%==o vssadmin delete shadows /for=C: /oldest
IF %delete%==a vssadmin delete shadows /all
IF %delete%==A vssadmin delete shadows /all


pause