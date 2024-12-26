@echo off
:init
setlocal DisableDelayedExpansion
title PC Fixer
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
title PC Fixer
:start
ECHO Welcome to the PC Fixer
echo ==========V 1.0==========

set /p option=Choose one option-SFC or DISM or CHKDSK-
IF %option%==SFC sfc /scannow
IF %option%==Sfc sfc /scannow
IF %option%==sfc sfc /scannow
IF %option%==DISM DISM.exe /online /cleanup-image /restorehealth
IF %option%==Dism DISM.exe /online /cleanup-image /restorehealth
IF %option%==dism DISM.exe /online /cleanup-image /restorehealth
IF %option%==CHKDSK set /p CHKDSK=Choose which drive to run CHKDSK on- && CHKDSK %CHKDSK% /r
IF %option%==Chkdsk set /p CHKDSK=Choose which drive to run CHKDSK on- && CHKDSK %CHKDSK% /r
IF %option%==chkdsk set /p CHKDSK=Choose which drive to run CHKDSK on- && CHKDSK %CHKDSK% /r

pause



