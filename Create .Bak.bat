@echo off
set filename=%1
For %%A in ("%filename%") do (
    set fp=%%~fA
    set drive=%%~dA
    set path=%%~pA
    set filename=%%~nA
    set extension=%%~xA
)
set /a count=0
set /a baknum=0
:checks
if %count% lss 1 (
    goto check
)
exit
:check
if %baknum%==0 (
    set baknum=
)
if not exist "%drive%%path%%filename%%baknum%%extension%.bak" (
    copy /y %1 "%drive%%path%%filename%%baknum%%extension%.bak"
	set /a count+=2
	set /a baknum=1
)
if exist "%drive%%path%%filename%%baknum%%extension%.bak" (
    set /a baknum+=1
	goto checks
)
