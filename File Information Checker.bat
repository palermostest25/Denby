@echo off
cd > tmpfile
set /p curcd=<tmpfile
del tmpfile
cd %userprofile%
title File Information
echo Checking Information...
echo(
set "filename=%~1"
For %%A in ("%filename%") do (
    echo Full Path: %1
    echo Drive: %%~dA
    echo Path: %%~pA
    echo File Name Only: %%~nA
    echo Extension Only: %%~xA
    echo Expanded Path With Short Names: %%~sA
    echo Attributes: %%~aA
    echo Date and Time: %%~tA
    echo Size: %%~zA
    echo Drive + Path: %%~dpA
    echo Name.Ext: %%~nxA
    echo Full Path + Short Name: %%~fsA
)
pause
cd %curcd%
exit /b