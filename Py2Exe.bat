@echo off
:start
title Py2Exe
if "%~1" equ "" (
    echo Usage : Drag and Drop your batch file over this script:"%~nx0"  
    echo Press any key to exit && pause > nul && exit
)
python --version 3 > NUL
if errorlevel 1 goto errorNoPython
pip install pyinstaller
pyinstaller --onefile %1
echo.
echo 1=Yes
echo 2=No
set /p option=Would you like to remove the extra folders from this script?(1,2)-
if not defined option set option=1
if %option%==1 rmdir /s /q build && del /f /q *.spec
if %option%==Y rmdir /s /q build && del /f /q *.spec
if %option%==y rmdir /s /q build && del /f /q *.spec
if %option%==yes rmdir /s /q build && del /f /q *.spec
if %option%==Yes rmdir /s /q build && del /f /q *.spec
if %option%==YES rmdir /s /q build && del /f /q *.spec
echo.
cd > tmpfile
set /p curcd= < tmpfile
if exist tmpfile del /f /q tmpfile
move /y "dist\*.exe" "%curcd%" > nul
rmdir /s /q dist
echo Your file is in the same folder as the origional file
echo Press any key to exit
pause > nul
exit

:errorNoPython
echo Python Is Not Installed
echo Press any key to install python
pause > nul
python
echo Press any key to go back to the start
pause > nul
goto start