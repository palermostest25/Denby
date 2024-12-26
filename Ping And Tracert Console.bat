@echo off
title Ping/tracert console
:start
ECHO Welcome to the ping/tracert console
echo ==========V 1.0==========
set /p option=Choose one option-Ping or Tracert-
set /p ip=Choose one ip adress or website to run command on-
IF %option%==ping ping %ip%
IF %option%==Ping ping %IP%
IF %option%==PING ping %IP%
IF %option%==tracert tracert %IP%
IF %option%==Tracert tracert %IP%
IF %option%==TRACERT tracert %IP%

pause