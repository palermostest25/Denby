@echo off
:start
cls
title Power Options
ECHO ==========V 1.0==========
ECHO Choose an option
ECHO 1 = Logoff (Immediate)
ECHO 2 = Reboot
ECHO 3 = Hibernate
ECHO 4 = Shutdown
ECHO For Advanced Options Type "H"
ECHO To Abort Timed Shutdown Type 5 Into The "Choose One Option" Section
choice /c 12345H /m "Choose an Option- "
if errorlevel 1 set option=1
if errorlevel 2 set option=2
if errorlevel 3 set option=3
if errorlevel 4 set option=4
if errorlevel 5 set option=5
if errorlevel 6 set option=6
IF %option%==1 shutdown /l
IF %option%==5 shutdown /a 
IF %option%==6 goto qna
SET /p timeinput=Time Before Taking Action in Seconds(Cannot Use Lock And Timer)- 
set /a timecheck=%timeinput%
if %timecheck% == %timeinput% (goto :confirmed) else (echo Invalid Input && pause && goto start)
:confirmed
IF %option%==2 (
	SHUTDOWN -r /t %timeinput%
	echo Rebooting Down in %timeinput% Seconds
)
IF %option%==3 (
	SHUTDOWN /h /t %timeinput%
	echo Hibernating in %timeinput% Seconds
)
IF %option%==4 (
	SHUTDOWN /s /t %timeinput% /hybrid
	echo Shutting Down in %timeinput% Seconds
)
pause
exit
:qna
cls
title Help Screen
ECHO Welcome to the help page for the Power Options Program
ECHO Syntax=Power Option (1, 2, 3, 4, 5, or H)
ECHO Then Time in seconds
ECHO HELPFUL HINTS
ECHO 30 Minutes = 1800 Seconds
ECHO 1 Hour = 3600 Seconds
ECHO 2 Hours = 7200 Seconds
ECHO 4 Hours = 14400 Seconds
ECHO 10 Hours = 36000 Seconds
pause
goto start




