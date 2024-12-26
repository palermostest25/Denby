@echo off
title Robocopy Helper
echo Robocopy Helper
echo :start >> "%userprofile%\Desktop\Robocopy Sync Task.bat"
echo @echo off >> "%userprofile%\Desktop\Robocopy Sync Task.bat"
set /p amnt=How many file synces would you like?-
set loop=0
:loop
set /p source=Source(With quotes)-
set /p dest=Destination(With quotes)-
echo 1=Mirror
echo 2=Copy
set /p mrcp=Mirror or Copy?[1/2]-
if %mrcp%==1 set mrcp=/mir
if %mrcp%==2 set mrcp=/e
set robo=robocopy %source% %dest% %mrcp%
echo %robo% >> "%userprofile%\Desktop\Robocopy Sync Task.bat"
echo timeout 5 >> "%userprofile%\Desktop\Robocopy Sync Task.bat"
set robo=
set mrcp=
set source=
set dest=
set /a loop=%loop%+1 
if "%loop%"=="%amnt%" goto next
goto loop

:next
echo goto start >> "%userprofile%\Desktop\Robocopy Sync Task.bat"
echo Done!
pause
exit /b