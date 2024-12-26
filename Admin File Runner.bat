@echo off
:start
title Admin File Runner
if "%~1" equ "" (goto error)
cmd /min /C "set __COMPAT_LAYER=RUNASINVOKER && start "" %1"
goto end

:error
echo Error.
echo No arguments defined
echo Usage:
echo Drag your admin file over this script
echo Press any key to exit...
pause > nul
exit /b

:end
exit /b