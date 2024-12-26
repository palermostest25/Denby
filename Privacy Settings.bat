@echo off

:start
title Privacy Settings
ECHO Welcome to the privacy settings wizard!
echo ==========V 1.0==========
ECHO Choose An Option.
ECHO Decrypt (1)
ECHO Encrypt (2)
ECHO Overwrite (free space) (3)
set /p option=What Would your Like To Do?-
IF %option%==Decrypt set /p dir=What is your directory?- && cipher /d /s:%dir%
IF %option%==decrypt set /p dir=What is your directory?- && cipher /d /s:%dir%
IF %option%==DECRYPT set /p dir=What is your directory?- && cipher /d /s:%dir%
IF %option%==1 set /p dir=What is your directory?- && cipher /d /s:%dir%

IF %option%==Encrypt set /p dir=What is your directory?- && cipher /e /s:%dir%
IF %option%==encrypt set /p dir=What is your directory?- && cipher /e /s:%dir%
IF %option%==ENCRYPT set /p dir=What is your directory?- && cipher /e /s:%dir%
IF %option%==2 set /p dir=What is your directory?- && cipher /e /s:%dir%

IF %option%==Overwrite set /p ltr=What is your drive letter? (With a : at the end)- && set /p Wipe=Would You Like To Wipe Your Entire Hard Drive Or Just Overwrite Free Space(Free space=n)(Wipe=y)? (y/n)-
IF %option%==overwrite set /p ltr=What is your drive letter? (With a : at the end)- && set /p Wipe=Would You Like To Wipe Your Entire Hard Drive Or Just Overwrite Free Space(Free space=n)(Wipe=y)? (y/n)-
IF %option%==OVERWRITE set /p ltr=What is your drive letter? (With a : at the end)- && set /p Wipe=Would You Like To Wipe Your Entire Hard Drive Or Just Overwrite Free Space(Free space=n)(Wipe=y)? (y/n)-
IF %option%==3 set /p ltr=What is your drive letter? (With a : at the end)- && set /p Wipe=Would You Like To Wipe Your Entire Hard Drive Or Just Overwrite Free Space(Free space=n)(Wipe=y)? (y/n)-

IF %Wipe%==Y format %ltr% /fs:NTFS /p:1
IF %Wipe%==y format %ltr% /fs:NTFS /p:1
IF %Wipe%==N cipher /w:%ltr%
IF %Wipe%==n cipher /w:%ltr%

IF %Wipe%==Yes format %ltr% /fs:NTFS /p:1
IF %Wipe%==yes format %ltr% /fs:NTFS /p:1
IF %Wipe%==No cipher /w:%ltr%
IF %Wipe%==no cipher /w:%ltr%


pause