@echo off
title File Comaprer
:start
ECHO Welcome to the File Comparer
echo ==========V 1.0==========
set /p opt1=File one(Full Path)-
set /p opt2=File two(Full Path)-
ECHO=============================                 
fc %opt1% %opt2%
echo Press any key to exit
pause > nul
exit /B