@echo off & setlocal

call :IsAdmin || set args=%* && (call :Elevate & exit /b)

echo Now Running Elevated, Arguments Received:
echo.  %*
pause

:: code goes here


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