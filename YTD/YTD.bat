@echo off
:start
cls
title Youtube downloader script
setlocal enabledelayedexpansion
set ffmpeg_location="%userprofile%\Desktop\Tools\YTD\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe"
set output_location="%userprofile%\Desktop\%%(title)s.%%(ext)s"
set options=--no-mtime --ffmpeg-location %ffmpeg_location% -o %output_location%

echo Youtube downloader script
set /p URL="Enter video URL Here: "
echo.
youtube-dl.exe --list-formats %URL%
if %errorlevel%==1 goto error1

:choose
set confirm=x
echo.
echo --------------------------------------------------------------------------
echo 1. Download automatically (default is best video + audio muxed) (recomended)
echo 2. Download the best quality single file, no mux
echo 3. Download the highest quality audio + video formats, attempt to merge to mp4
echo 4. Let me choose the video and audio formats to combine
echo 5. Download ONLY audio or video
echo.
set /p choice="Type your choice number: "
if not defined choice set choice=1 && echo Defaulted to 1 as user did not enter a choice
echo.
if %choice%==1 (
echo Output format will be:
youtube-dl.exe %URL% --get-format
set /p confirm="Ok? (Y/N): "
goto :download_1
)
:download_1
if /i !confirm!==y (
youtube-dl.exe %URL% %options%
goto :finished
)
if /i !confirm!==n goto :choose
if %choice%==2 (
echo Output format will be:
youtube-dl.exe -f best %URL% --get-format
set /p confirm="Ok? (Y/N): "
goto :download_2
)
:download_2
if /i !confirm!==y (
youtube-dl.exe -f best %URL% %options%
goto :finished
)
if /i !confirm!==n goto :choose
if %choice%==3 (
youtube-dl.exe -f bestvideo+bestaudio/best --merge-output-format mp4 %URL% %options%
goto :finished
)
if %choice%==4 (
echo INSTRUCTIONS: Choose the audio format code for the video or audio quality you want from the list above, on the left side in the green, Enter the number.
set /p videoformat="Video format code: "
set /p audioformat="Audio format code: "
echo !videoformat!%+!audioformat!
youtube-dl.exe %URL% -f !videoformat!%+!audioformat! --merge-output-format mp4 %options%
goto :finished
)
if %choice%==5 (
youtube-dl.exe --list-formats %URL%
echo INSTRUCTIONS: Choose the audio format code for the video or audio quality you want from the list above, on the left side in the green, Enter the number.
set /p format="Format code: "
youtube-dl.exe %URL% -f !format! %options%
goto :finished
)
:error
echo.
echo Something went wrong. Invalid input
echo Your entries: !choice! !confirm!
exit /b
:finished
echo.
echo Program finished
pause
exit

:error1
echo Error
echo Press any key to go back to the start
pause > nul
goto start


