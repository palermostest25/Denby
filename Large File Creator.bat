@echo off
:start
title Large file creator
ECHO Welcome to the large file craetor
ECHO ==========V 1.0==========
:before
set /p where=Where do you want to store this file?(full path)(With name and extension)(If it has a space in it make sure to put quotes around it)-
:between
set /p size=How big do you want this file?-
fsutil file createnew %where% %size%

pause