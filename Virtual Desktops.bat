@echo off
title Virtual Desktop Creator
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
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

title Virtual Desktop Creator
if /i "%cd%"=="%userprofile%\Desktop" (
    echo This Script is Running on the Desktop, the Desktop Folder is About to be Moved, Please Move This to Another Folder, Preferably Your Users Directory.
    pause
    exit /b
) else (
    echo Script is NOT running on the Desktop. This is Intended Behaviour, Continuing...
)
echo OneDrive is NOT SUPPORTED By This Script!
cd %userprofile%
echo Warning! This Script Will Move Your Desktop Folder, NOT DELETE IT, DON'T WORRY!
pause
if not exist DesktopOld\ move Desktop DesktopOld || echo DesktopOld Folder Already Exists
mkdir Desktops
set /p "desktops=Enter the Names of the Desktops You Would Like to Create, Seperated by Commas- "
set desktops=%desktops%, Empty
cd Desktops
for %%a in (%desktops%) do (
    mkdir "%%a"
    echo Welcome to %%a > "%%a\Welcome to %%a!.txt"
)
mkdir SwitchScripts
cd SwitchScripts

setlocal enabledelayedexpansion

set /a count=1

for %%A in (%desktops%) do (
    set "name=%%A"
    set "name=!name: =!"
    
    set filename=SwitchTo!name!.bat
    echo @echo off >> !filename!
    echo rmdir %userprofile%\Desktop >> !filename!
    echo mklink /d %userprofile%\Desktop %userprofile%\Desktops\!name! >> !filename!
    echo powershell -command "(New-Object -ComObject Shell.Application).Windows().Item().Refresh()" >> !filename!
    set /a count+=1
)

endlocal

rmdir %userprofile%\Desktop
mklink /d %userprofile%\Desktop %userprofile%\Desktops\Empty
powershell -command "(New-Object -ComObject Shell.Application).Windows().Item().Refresh()"
echo All Folders Have Been Created, File Explorer Will Now Open to the SwitchScripts Folder. Thank You for Using this Script!
explorer %userprofile%\Desktops\SwitchScripts
pause