@echo off
:start
title File Downloader
cls
echo File Downloader by Denby Daily
echo ==========V 1.0==========
echo Please do not put quotes on any awnser, doing so will result in an error
echo.
echo Please provide the exact download link for the file, eg: https://dl.malwarewatch.org/windows/Windows%20XP%20%28x64%29.iso
set /p "source=Download link- "
echo.
echo Plese provide the place to put the downloaded file, NOTE: Include the file extension, eg: C:\Users\denby\Desktop\WinXP.iso
set /p "dest=Destination file location- "
echo.
echo Transferring from "%source%" to "%dest%"
echo 1=Yes
echo 2=No
set /p "confirm=Is this correct? [1,2]- "
if %confirm%==n goto start
if %confirm%==N goto start
if %confirm%==2 goto start
if %confirm%==no goto start
if %confirm%==No goto start
if %confirm%==NO goto start
echo Starting...
echo To cancel press CTRL+C
powershell start-bitstransfer -Priority foreground -Source "%source%" -Destination "%dest%"
echo Successfully transferred from "%source%" to "%dest%"!
echo Press any key to exit...
pause > nul
exit /b


