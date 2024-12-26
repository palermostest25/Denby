@echo off & setlocal
 
call :IsAdmin || set args=%* && (call :Elevate & exit /b)

echo Now Running Elevated, Arguments Received:
echo.  %*

title Automatic SymLink Creator
set "target=%~f1"
set "link=%USERPROFILE%\Desktop\%~n1 - Link%~x1"
set "drive=%~d1"
echo.
echo Link: %link%
echo Target: %target%
echo Drive: %drive%

if "%drive%" NEQ "C:" (
    echo.
    echo Creating SymLink as the File is not on the C Drive.
	echo Creating SymLink from "%link%" to "%target%"
	pause
    mklink "%link%" "%target%"
    goto end
)

if "%~a1" GTR "d" (
    echo.
	echo Creating SymLink from "%link%" to "%target%"
	pause
    mklink /D "%link%" "%target%"
) else (
    echo.
	echo Creating SymLink from "%link%" to "%target%"
	pause
    mklink /H "%link%" "%target%"
)

:end
pause


goto :EOF

:IsAdmin
  net session >NUL 2>&1
goto :EOF
 
:Elevate
  if defined args set args=%args:^=^^%
  if defined args set args=%args:<=^<%
  if defined args set args=%args:>=^>%
  if defined args set args=%args:&=^&%
  if defined args set args=%args:|=^|%
  if defined args set "args=%args:"=\"\"%"
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    " Start-Process -Wait -Verb RunAs -FilePath cmd -ArgumentList \"/c \"\" cd /d \"\"%CD% \"\" ^&^& \"\"%~f0\"\" %args% \"\" \" "
goto :EOF