@echo off
title MS-DOS Mode for Windows 10 setup
echo MS-DOS Mode Implementation for Windows 10 by Denby Daily
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=
echo Waiting for elevation...
echo =-=-=-=-=-=-=-=-=-=-=-=-=

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
cd > "%userprofile%\tmpfile"
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

REM ~-~-~-~-~-~-~-~ Batch file starts here
echo.
echo Starting the file... 
ping localhost -n 2 > nul
set /p curcd=<"%userprofile%\tmpfile"
del /q "%userprofile%\tmpfile"
cd %curcd%
copy "msdos.bat" "C:\Windows\System32\msdos.bat"
copy "reboot.bat" "C:\Windows\System32\reboot.bat"
copy "win.bat" "C:\Windows\System32\win.bat"
echo.
echo Setup is almost complete.
echo Please use WinXEditor to add "C:\Windows\System32\msdos.bat" to the Win+X menu.
echo Under any group press the insert key, then in the "filename" field enter "C:\Windows\System32\msdos.bat"
echo Then click "Restart explorer" for the changes to take effect.
echo If you do not intend to put this software in the Win+X menu please close this window, setup will be complete.
echo To run this software without the Win+X menu, navigate to "C:\Windows\System32" and launch "msdos.bat" to restart to MS-DOS mode.
echo.
echo Press any key to launch WinXEditor...
pause > nul
cd WinXEditor
WinXEditor.exe
echo Setup complete!
echo Press any key to exit...
pause > nul
exit /B