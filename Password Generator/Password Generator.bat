@echo off
set count=0
:start
title Password Generator
echo Checking for python installation
python --version 3 > NUL
if errorlevel 1 goto errorNoPython
echo Checking Complete.
set /P lengthnumberuser=How Long Would You Like Your Password?(Between 1 and 1000)-
if not defined lengthnumberuser set lengthnumberuser=12
if %lengthnumberuser% gtr 1000 echo Your Password Is Too Long Or Not A Number && echo Press Any Key To Go Back To The Start && pause > nul && cls && goto start
if %lengthnumberuser% lss 1 echo Your Password Is Too Short Or Not A Number && echo Press Any Key To Go Back To The Start && pause > nul && cls && goto start
echo %lengthnumberuser% > tmpfile1.txt
python "password generator.py" > tmpfile.txt
echo Your Password Is:
type tmpfile.txt
type tmpfile.txt | clip
del tmpfile.txt
del tmpfile1.txt
echo The password has been copied to the clipboard
if %count%==1 goto CA
echo 1=Yes
echo 2=No
set /p openexcel=Would you like to open the Excel Password document?-
if %openexcel%==1 start "" "X:\My Drive\Passwords.xlsx"
if %openexcel%==y start "" "X:\My Drive\Passwords.xlsx"
if %openexcel%==Y start "" "X:\My Drive\Passwords.xlsx"
if %openexcel%==Yes start "" "X:\My Drive\Passwords.xlsx"
if %openexcel%==yes start "" "X:\My Drive\Passwords.xlsx"
:CA
echo 1=Yes
echo 2=No
set /p createanother=Would you like to generate another password?-
if %createanother%==Y set count=1 && cls && goto start
if %createanother%==Yes set count=1 && cls && goto start
if %createanother%==yes set count=1 && cls && goto start
if %createanother%==y set count=1 && cls && goto start
if %createanother%==1 set count=1 && cls && goto start





echo Press Any Key To Exit
pause > nul
exit



:errorNoPython
echo Python is not installed
python
pause
goto start