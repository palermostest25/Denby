@echo off
set 1=%1
if %1%==/noadmin goto start
if %1%==/Noadmin goto start
if %1%==/NoAdmin goto start
if %1%==/NOADMIN goto start
:init
setlocal DisableDelayedExpansion
title New PC Setup
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~dpnx0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO Invoking UAC for Privilege Escalation
ECHO.

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
if '%cmdInvoke%'=='1' goto InvokeCmd 
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:start
powershell -noprofile set-executionpolicy Unrestricted
title New PC Setup
echo New PC Setup
winget > nul
if %errorlevel%==1 start /max https://aka.ms/getwinget
echo 1=Normally
echo 2=Via Imported List
set /p normallyorimportedlist=Would you like to install the programs normally or via importing the list?-
if %normallyorimportedlist%==2 goto importedlist
echo 1=Yes
echo 2=No
set /p installlibre=Would you like to install LibreOffice instead of Microsoft Office?-
if %installlibre%==1 (set installlibreoffice=1)
if %installlibre%==y (set installlibreoffice=1)
if %installlibre%==Y (set installlibreoffice=1)
if %installlibre%==yes (set installlibreoffice=1)
if %installlibre%==Yes (set installlibreoffice=1)
if %installlibre%==YES (set installlibreoffice=1)
echo 1=Yes
echo 2=No
set /p installgamingstuff=Would you like to install gaming stuff?-
if %installgamingstuff%==1 (set installgamingstuff=1)
if %installgamingstuff%==yes (set installgamingstuff=1)
if %installgamingstuff%==Yes (set installgamingstuff=1)
if %installgamingstuff%==YES (set installgamingstuff=1)
if %installgamingstuff%==y (set installgamingstuff=1)
if %installgamingstuff%==Y (set installgamingstuff=1)

echo 1=Yes
echo 2=No
set /p installgamingpcstuff=Would you like to install gaming PC stuff?-
if %installgamingpcstuff%==1 (set installgamingpcstuff=1)
if %installgamingpcstuff%==yes (set installgamingpcstuff=1)
if %installgamingpcstuff%==Yes (set installgamingpcstuff=1)
if %installgamingpcstuff%==YES (set installgamingpcstuff=1)
if %installgamingpcstuff%==y (set installgamingpcstuff=1)
if %installgamingpcstuff%==Y (set installgamingpcstuff=1)
rem Programs
echo Press any key to install all useful software...
pause > nul
winget install vscode
winget install winrar
winget install 7zip.7zip
winget install "Google Chrome"
winget install VMware.WorkstationPro
winget install wiztree
winget install python
pip install pygame
winget install Spotify.Spotify
winget install powerautomate
winget install EZBSystems.UltraISO
winget install wingetcreate
winget install Microsoft.VisualStudio.2022.Community
winget install Microsoft.WindowsTerminal
winget install Microsoft.WindowsTerminal.Preview
winget install Microsoft.PowerShell
winget install GitHub.GitHubDesktop
winget install GitHub.cli
winget install git.git
winget install Anaconda.Miniconda3
winget install Google.Drive
winget install JanDeDobbeleer.OhMyPosh -s winget
winget install anydesk
winget install Twilio.Authy
winget install CPUID.CPU-Z
winget install CrystalDewWorld.CrystalDiskInfo
winget install CrystalDewWorld.CrystalDiskMark
winget install CThingSoftware.Meazure
winget install namazso.OpenHashTab
winget install MediaArea.MediaInfo.GUI
winget install Mp3tag.Mp3tag
winget install sharex.sharex
winget install Piriform.Recuva
winget install StefanSundin.Superf4
winget install TechPowerUp.GPU-Z
winget install VideoLAN.VLC
winget install clsid2.mpc-hc
winget install TGRMNSoftware.BulkRenameUtility
winget install OpenJS.NodeJS
winget install Unigine.HeavenBenchmark
winget install Unigine.ValleyBenchmark
winget install Unigine.SuperpositionBenchmark
winget install AOMEI.Backupper
winget install AOMEI.PartitionAssistant
winget install 9PGZKJC81Q7J
winget install 9MV0B5HZVK9Z
winget install Google.Chrome.Canary
winget install Google.EarthPro
winget install BotProductions.IconViewer
winget install 9N0TN65P5BF6
winget install 9WZDNCRFJ3TJ
winget install Notepad++.Notepad++
winget install OBSProject.OBSStudio
winget install Plex.Plex
winget install Microsoft.PowerToys
winget install PrivateInternetAccess.PrivateInternetAccess
winget install 9NCBCSZSJRSB
winget install GIMP.GIMP
winget install Elgato.StreamDeck
winget instalĺ Audacity.Audacity
winget install flux.flux
winget install JetBrains.PyCharm.Community
winget install Musescore.Musescore
winget install VirusTotal.VirusTotalUploader
winget install WinMerge.WinMerge
winget install AntibodySoftware.WizFile
winget install Nvidia.Broadcast
winget install TeamViewer.TeamViewer
winget install Brave.Brave
winget install BrickLink.Studio
winget install HandBrake.HandBrake
winget install Piriform.Speccy
if %installgamingstuff%==1 (
    winget install Oracle.JavaRuntimeEnvironment
    winget install valve.steam
    winget install EpicGames.EpicGamesLauncher
    winget install Mojang.MinecraftLauncher
    winget install Discord.Discord
)
if %installgamingpcstuff%==1 (
    winget install iCUE
    winget install Elgato.StreamDeck
)
if %installlibreoffice%==1 (
    winget install TheDocumentFoundation.LibreOffice
)
goto afterimportedlist
:importedlist
start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/DenbyDaily/SyncWingetListTxt/main/list.txt" -destination "$home\Desktop\list.txt"
winget import -i "%userprofile%\Desktop\list.txt"
start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/DenbyDaily/SyncWingetListTxt/main/ThingsNotInWinget.txt" -destination "$home\Desktop\Things To Do After Imported List.txt"
:afterimportedlist
start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/palermostest25/To-Do-After-Fix/main/To%20Do%20Afterwards.txt" -destination "$home\Desktop\To Do Afterwards.txt"
rem Activator
powershell -noprofile start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/palermostest25/Activator-Downloader/main/Activator.bat" -destination "$home\Activator.bat"
powershell -noprofile "$s=(New-Object -COM WScript.Shell).CreateShortcut('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Activator.lnk');$s.TargetPath='$home\Activator.bat';$s.Save()"
rem PowerShell Prompt
mkdir "%userprofile%\Documents\WindowsPowerShell"
mkdir "%userprofile%\Documents\PowerShell"
del "%userprofile%\Documents\WindowsPowerShell\paradox.omp.json"
del "%userprofile%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
powershell -noprofile start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/paradox.omp.json" -destination "$home\Documents\WindowsPowerShell\paradox.omp.json"
powershell -noprofile start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/palermostest25/PowerShell-Profile/main/Microsoft.PowerShell_profile.ps1" -destination "$home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
powershell -noprofile start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/paradox.omp.json" -destination "$home\Documents\PowerShell\paradox.omp.json"
powershell -noprofile start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/palermostest25/PowerShell-Profile/main/Microsoft.PowerShell_profile.ps1" -destination "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
rem Shortcuts to Windows Terminal
start /maẋ https://github.com/DenbyDaily/Shortcuts-for-WT
rem Context Menu
start /max https://github.com/palermostest25/Reg-Download
powershell set-executionpolicy RemoteSigned
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Power Default Browser Downloades and Optional Features", 100, 7
rem Ultimate Performance
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg.cpl
rem Set Default Browser
explorer.exe shell:::{17cd9488-1228-4b2f-88ce-4298e93e0966} -Microsoft.DefaultPrograms\pageDefaultProgram
rem Windows Terminal Settings
start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/palermostest25/WT-Settings-Downloader/main/terminalsettings.json" -destination "C:\Users\PalermoS\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
start-bitstransfer -priority foreground -source "https://raw.githubusercontent.com/palermostest25/WT-Settings-Downloader/main/terminalpreviewsettings.json" -destination "C:\Users\PalermoS\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
rem Download files
start /max https://www.microsoft.com/en-au/microsoft-365/onedrive/onedrive-for-business
rem Turn Windows Features On or Off
OptionalFeatures.exe

:end
echo Press any key to exit...
pause > nul
exit /B