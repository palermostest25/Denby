@echo off
:start
title Package Manager
Echo Welcome to the package manager
echo ==========V 1.0==========
Echo Choose an option
Echo Unistall(1)
echo Install(2)
echo Show (Details about package)(3)
echo Import(4)
echo Export(5)
echo Update, Upgrade(6)
set /p option=What would you like to do?-

Rem Uninstall
if %option%==Uninstall set binary=uninstall && set /p package=What would you like to uninstall?-
if %option%==uninstall set binary=uninstall && set /p package=What would you like to uninstall?-
if %option%==UNINSTALL set binary=uninstall && set /p package=What would you like to uninstall?-
if %option%==Remove set binary=uninstall && set /p package=What would you like to uninstall?-
if %option%==remove set binary=uninstall && set /p package=What would you like to uninstall?-
if %option%==REMOVE set binary=uninstall && set /p package=What would you like to uninstall?-
if %option%==1 set binary=uninstall && set /p package=What would you like to uninstall?-

rem Install
if %option%==Install set binary=install && set /p package=What would you like to install?-
if %option%==install set binary=install && set /p package=What would you like to install?-
if %option%==INSTALL set binary=install && set /p package=What would you like to install?-
if %option%==Add set binary=install && set /p package=What would you like to install?-
if %option%==add set binary=install && set /p package=What would you like to install?-
if %option%==ADD set binary=install && set /p package=What would you like to install?-
if %option%==2 set binary=install && set /p package=What would you like to install?-

rem Show
if %option%==Show set binary=show && set /p package=What package would you like to Show Details about?-
if %option%==show set binary=show && set /p package=What package would you like to Show Details about?-
if %option%==SHOW set binary=show && set /p package=What package would you like to Show Details about?-
if %option%==About set binary=show && set /p package=What package would you like to Show Details about?-
if %option%==about set binary=show && set /p package=What package would you like to Show Details about?-
if %option%==ABOUT set binary=show && set /p package=What package would you like to Show Details about?-
if %option%==3 set binary=show && set /p package=What would you like to show details about?-

rem Import
if %option%==Import set importexport=import && set /p import=Where is your file?(Path, name and extension)- && goto after
if %option%==import set importexport=import && set /p import=Where is your file?(Path, name and extension)- && goto after
if %option%==IMPORT set importexport=import && set /p import=Where is your file?(Path, name and extension)- && goto after
if %option%==4 set importexport=import && set /p import=Where is your file?(Path, name and extension)- && goto after

rem Export
if %option%==Export set importexport=export && set /p import=Where would you like to save this file?(Path, name and extension)- && goto after
if %option%==export set importexport=export && set /p import=Where would you like to save this file?(Path, name and extension)- && goto after
if %option%==EXPORT set importexport=export && set /p import=Where would you like to save this file?(Path, name and extension)- && goto after
if %option%==5 set importexport=export && set /p import=Where would you like to save this file?(Path, name and extension)- && goto after

rem Update/Upgrade
if %option%==Update set binary=upgrade && set /p package=What package would you like to upgrade?-
if %option%==update set binary=upgrade && set /p package=What package would you like to upgrade?-
if %option%==UPDATE set binary=upgrade && set /p package=What package would you like to upgrade?-
if %option%==Upgrade set binary=upgrade && set /p package=What package would you like to upgrade?-
if %option%==upgrade set binary=upgrade && set /p package=What package would you like to upgrade?-
if %option%==UPGRADE set binary=upgrade && set /p package=What package would you like to upgrade?-
if %option%==6 set binary=upgrade && set /p package=What would you like to upgrade?-
if %package%==all winget upgrade --all
if %package%==All winget upgrade --all
if %package%==ALL winget upgrade --all
winget %binary% %package%

pause
exit

:after
winget %importexport% %import%

:end
pause
exit




















