@echo off
if "%1"=="" (
    goto init
)
set 1=%1
if %1%==/noadmin goto start
if %1%==/Noadmin goto start
if %1%==/NoAdmin goto start
if %1%==/NOADMIN goto start
if %1%==/notitle set changetitle=0
if %1%==/Notitle set changetitle=0
if %1%==/NoTitle set changetitle=0
if %1%==/NOTITLE set changetitle=0
if %1%==/notitleadmin goto starttitle
if %1%==/Notitleadmin goto starttitle
if %1%==/NoTitleAdmin goto starttitle
if %1%==/NOTITLEADMIN goto starttitle
if %1%==/auto set auto1=1
if %1%==/Auto set auto1=1
if %1%==/AUTO set auto1=1
if %1%==/autoserver set auto2=1
if %1%==/Autoserver set auto2=1
if %1%==/AutoServer set auto2=1
if %1%==/AUTOSERVER set auto2=1
:init
setlocal DisableDelayedExpansion
if not defined changetitle (
    title Windows 10 and 11 Digital Activation
)
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
if not defined changetitle (
    title Windows 10 and 11 Digital Activation
)
cls
:starttitle
echo Windows 10 and 11 Digital Activation
echo ==========V 2.0==========
echo By Denby Daily
echo Website: https://denby.dev/
echo WARNING: This script will override any current windows product key present on your system.
echo 1=Home
echo 2=Home N
echo 3=Home Single Language
echo 4=Home Country Specific
echo 5=Professional
echo 6=Professional N
echo 7=Pro for Workstations
echo 8=Pro for Workstations N
echo 9=Pro Education
echo 10=Pro Education N
echo 11=Education
echo 12=Education N
echo 13=Enterprise
echo 14=Enterprise N
echo 15=Enterprise G
echo 16=Enterprise G N
echo 17=Windows Server(Will take you to a different menu)
echo 18=Prehistoric(Will take you to a different menu)
echo 19=Other stuff(Will take you to a different menu)
echo 20=Download Windows ISO's
echo 21=Download Other software
echo 22=Download MS-DOS
echo 23=Exit
set /p option=Which edition of windows would you like to activate?(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17) (The default is professional)-
:set1
if not defined option set option=5
if %option%==1 set key=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99 && goto run
if %option%==2 set key=3KHY7-WNT83-DGQKR-F7HPR-844BM && goto run
if %option%==3 set key=7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH && goto run
if %option%==4 set key=PVMJN-6DFY6–9CCP6–7BKTT-D3WVR && goto run
if %option%==5 set key=W269N-WFGWX-YVC9B-4J6C9-T83GX && goto run
if %option%==6 set key=MH37W-N47XK-V7XM9-C7227-GCQG9 && goto run
if %option%==7 set key=NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J && goto run
if %option%==8 set key=9FNHH-K3HBT-3W4TD-6383H-6XYWF && goto run
if %option%==9 set key=6TP4R-GNPTD-KYYHQ-7B7DP-J447Y && goto run
if %option%==10 set key=YVWGF-BXNMC-HTQYQ-CPQ99-66QFC && goto run
if %option%==11 set key=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 && goto run
if %option%==12 set key=2WH4N-8QGBV-H22JP-CT43Q-MDWWJ && goto run
if %option%==13 set key=NPPR9-FWDCX-D2C8J-H872K-2YT43 && goto run
if %option%==14 set key=DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4 && goto run
if %option%==15 set key=YYVX9-NTFWV-6MDM3-9PT4T-4M68B && goto run
if %option%==16 set key=44RPN-FTY23-9VTTB-MP9BX-T84FV && goto run

if %option%==17 goto actvwinserver

if %option%==18 goto actvprehistoric

if %option%==19 goto otherstuff

if %option%==20 (
    start /max https://dl.malwarewatch.org/windows/
    start /max https://www.microsoft.com/en-au/software-download
    start /max https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/
    echo Press any key to exit...
    pause > nul
    exit
)

if %option%==21 (
    start /max https://dl.malwarewatch.org/software
    start /max https://dl.malwarewatch.org
    echo Press any key to exit...
    pause > nul
    exit
)

if %option%==22 (
    start /max https://dl.malwarewatch.org/ms-dos/
    echo Press any key to exit...
    pause > nul
    exit
)

if %option%==23 (
    exit
)

if %option%==exit (
    exit
)

if %option%==Exit (
    exit
)

if %option%==EXIT (
    exit
)

goto error

:run
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (goto actualrun) else (goto error5)
:actualrun
echo Please wait.
echo This will take a while.
slmgr /upk
slmgr /ipk %key%
slmgr /skms kms8.msguides.com
slmgr /ato
echo Windows has been activated successfully!
echo Please close any additional windows that have opened.
echo Enjoy!
echo Press any key to exit...
pause > nul
exit

:error
echo Error.
echo You did not enter a valid option: %option%
echo Press any key to go back to the start
pause > nul
goto start

:error1
echo Error.
echo You did not enter a valid option: %serveropt%
echo Press any key to go back to the start
pause > nul
goto start

:error2
echo Error.
echo You did not enter a valid option: %otherstuffopt%
echo Press any key to go back to the start
pause > nul
goto start

:error3
echo Error.
echo You did not enter a valid option: %prehistoricopt%
echo Press any key to go back to the start
pause > nul
goto start

:error4
echo Error.
echo You did not enter a valid option: %premicrosoftofficeopt%
echo Press any key to go back to the start
pause > nul
goto start

:error5
echo Error.
echo This option requires elevation.
echo Press any key to go back to the start
pause > nul
goto start

:error6
echo Error.
echo This option requires elevation.
echo Press any key to go back to the start
pause > nul
goto start

:actvwinserver
cls
echo Warning: Activating windows server will restart your computer.
echo 1=Windows Server 2016 Essentials
echo 2=Windows Server 2016 Standard
echo 3=Windows Server 2016 Datacenter

echo 4=Windows Server 2019 Essentials
echo 5=Windows Server 2019 Standard
echo 6=Windows Server 2019 Datacenter

echo 7=Windows Server 2022 Standard
echo 8=Windows Server 2022 Datacenter

echo 9=Windows Server Semi-Annual Standard
echo 10=Windows Server Semi-Annual Datacenter

set /p serveropt=Which edition of windows server would you like to activate?(1,2,3,4,5,6,7,8,9,10) (The default is 2022 Datacenter)-
:set2
if not defined serveropt set serveropt=8
if %serveropt%==1 set serverkey=JCKRF-N37P4-C2D82-9YXRT-4M63B && set serverver=ServerEssentials && goto serverrun
if %serveropt%==2 set serverkey=WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY && set serverver=ServerStandard && goto serverrun
if %serveropt%==3 set serverkey=CB7KF-BWN84-R7R2Y-793K2-8XDDG && set serverver=ServerDatacenter && goto serverrun
if %serveropt%==4 set serverkey=WVDHN-86M7X-466P6-VHXV7-YY726 && set serverver=ServerEssentials && goto serverrun
if %serveropt%==5 set serverkey=N69G4-B89J2-4G8F4-WWYCC-J464C && set serverver=ServerStandard && goto serverrun
if %serveropt%==6 set serverkey=WMDGN-G9PQG-XVVXX-R3X43-63DFG && set serverver=ServerDatacenter && goto serverrun
if %serveropt%==7 set serverkey=VDYBN-27WPP-V4HQT-9VMD4-VMK7H && set serverver=ServerStandard && goto serverrun
if %serveropt%==8 set serverkey=WX4NM-KYWYW-QJJR4-XV3QB-6VM33 && set serverver=ServerDatacenter && goto serverrun
if %serveropt%==9 set serverkey=N2KJX-J94YW-TQVFB-DG9YT-724CC && set serverver=ServerStandard && goto serverrun
if %serveropt%==10 set serverkey=6NMRW-2C8FM-D24W7-TQWMY-CWH2D && set serverver=ServerDatacenter && goto serverrun
goto error1

:serverrun
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (goto actualrun1) else (goto error6)
pause
:actualrun1
slmgr /upk
echo n | Dism /online /Set-Edition:%serverver% /ProductKey:%serverkey% /AcceptEula
slmgr /skms kms8.msguides.com
slmgr /ato
shutdown -r /t 0

:otherstuff
cls
echo 1=UltraISO
echo 2=VMWare Workstation 12
echo 3=VMWare Workstation 14
echo 4=VMWare Workstation 16
echo 5=WinRAR
echo 7=List of all the things paid for
echo 8=500 Blooket Coins
echo 9=YouTube Downloader
echo.
echo ===============================
echo Warning: The next of these items are cracked and include instructions on how to crack them.
echo ===============================
echo.
echo 11=RamDisk
echo 12=WinToUSB
echo 13=Uninstall Tool 3510
echo 14=All versions of VEGAS Pro
echo 15=Adobe Create Cloud (malwarewatch.org)

set /p otherstuffopt=Please enter your option-

if %otherstuffopt%==ultraiso (
    goto ultraiso
)

if %otherstuffopt%==Ultraiso (
    goto ultraiso
)

if %otherstuffopt%==UltraIso (
    goto ultraiso
)

if %otherstuffopt%==UltraISO (
    goto ultraiso
)

if %otherstuffopt%==ULTRAISO (
    goto ultraiso
)

if %otherstuffopt%==1 (
    :ultraiso
    echo Use this key:
    echo Any Name
    echo 4434-8CB4-ECAB-06E0
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==2 (
    echo Use one of these keys:
    echo GY7EA-66D53-M859P-5FM7Z-QVH96
    echo CC15K-AYF01-H897Q-75Y7E-PU89A
    echo UC3WA-DFE01-M80DQ-AQP7G-PFKEF
    echo ZA1RA-82EDM-M8E2P-YGYEZ-PC8ED
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==3 (
    echo Use this key:
    echo YV54A-2ZW5P-M887Y-UWXNE-QPUXDYV54A-2ZW5P-M887Y-UWXNE-QPUXD
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==4 (
    echo Use this key:
    echo ZF3R0-FHED2-M80TY-8QYGC-NPKYF
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==winrar (
    goto winrar
)

if %otherstuffopt%==Winrar (
    goto winrar
)

if %otherstuffopt%==WinRar (
    goto winrar
)

if %otherstuffopt%==WinRAR (
    goto winrar
)

if %otherstuffopt%==WINRAR (
    goto winrar
)

if %otherstuffopt%==5 (
    :winrar
    echo Copy this into a text file in the winrar installation directory, normally "C:\Program Files\WinRAR" called "rarreg.key"
    echo.
    echo RAR registration data
    echo WinRAR
    echo Unlimited Company License
    echo UID=4b914fb772c8376bf571
    echo 6412212250f5711ad072cf351cfa39e2851192daf8a362681bbb1d
    echo cd48da1d14d995f0bbf960fce6cb5ffde62890079861be57638717
    echo 7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565
    echo b41bcf56929486b8bcdac33d50ecf773996052598f1f556defffbd
    echo 982fbe71e93df6b6346c37a3890f3c7edc65d7f5455470d13d1190
    echo 6e6fb824bcf25f155547b5fc41901ad58c0992f570be1cf5608ba9
    echo aef69d48c864bcd72d15163897773d314187f6a9af350808719796
    echo.
    echo Press any key to exit...
    pause > nul
    exit /B
)


)

if %otherstuffopt%==7 (
    echo Here is the list:
    echo Steam Stuff
    echo Private Internet Access
    echo Xbox Game Pass/EA Play
    echo Spotify Premium
    echo Netflix
    echo Abelton Live 11 Intro
    echo Google Drive - 100GB
    echo Microsoft Office 365  with 1TB OneDrive
    echo Google Domains - Denby.dev
    echo Windows License - Windows 10 Pro
    echo Adobe Creative Cloud
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==8 (
    start /max https://drive.google.com/file/d/1riO0k3-lAuJmoLnCmHJBPsEN4r8IOtL5/view?usp=sharing
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==9 (
    start /max https://drive.google.com/file/d/16FDyTgA2F3rhBPsx_AEwdnJS84vv-xkk/view?usp=sharing
    echo Press any key to exit...
    pause > nul
    exit /B
)

)

if %otherstuffopt%==11 (
    start /max https://dl.malwarewatch.org/software/useful/RAMDisk.zip
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==12 (
    start /max https://dl.malwarewatch.org/software/useful/WinToUSB.zip
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==13 (
    start /max https://dl.malwarewatch.org/software/useful/UninstallTool3510.zip
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==14 (
    start /max https://dl.malwarewatch.org/software/useful/vegas/
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %otherstuffopt%==15 (
    start /max https://dl.malwarewatch.org/software/useful/adobe/
    echo Press any key to exit...
    pause > nul
    exit /B
)

goto error2

:actvprehistoric
cls
echo 1=Windows XP
echo 2=Windows XP (X86)
echo 3=Windows 2000
echo 4=Windows ME
echo 5=Windows 98 SE
echo 6=Windows 95
echo 7=Windows NT 4
echo 8=Microsoft Office(Will take you to a different menu)
echo 9=Download Microsoft Office (Prehistoric)
set /p prehistoricopt=Please enter your option-
if %prehistoricopt%==1 (
    echo Use this key:
    echo VCFQD-V9FX9-46WVH-K3CD4-4J3JM
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==2 (
    echo Use this key:
    echo MRX3F-47B9T-2487J-KWKMF-RPWBY
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==3 (
    echo Use this key:
    echo G7VKM-WM72Y-JJXGT-F4BJG-D6RPQ
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==4 (
    echo Use this key:
    echo B6BYC-6T7C3-4PXRW-2XKWB-GYV33
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==5 (
    echo Use this key:
    echo RW9MG-QR4G3-2WRR9-TG7BH-33GXB
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==6 (
    echo Use this key:
    echo 24796-OEM-0014736-66386
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==7 (
    echo Use these keys:
    echo 28997-OEM-0025957-49297 30495-OEM-0006276-08104
    echo 40159-OEM-0211111-11111 34698-OEM-0039682-50656
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %prehistoricopt%==8 (
    goto premicrosoftoffice
)

if %prehistoricopt%==9 (
    start /max https://dl.malwarewatch.org/software/useful/office/
    echo Press any key to exit...
    pause > nul
    exit /B

)

goto error3

:premicrosoftoffice
cls
echo 1=Microsoft Office 97
echo 2=Microsoft Office 200
echo 3=Microsoft Office 2007
set /p premicrosoftofficeopt=Please enter your option-
if %premicrosoftofficeopt%==1 (
    echo Use this key:
    echo 1112-1111111
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %premicrosoftofficeopt%==2 (
    echo Use this key:
    echo H4GW2-2M9C4-R8YWX-BYJFT-KKFQ3
    echo Press any key to exit...
    pause > nul
    exit /B
)

if %premicrosoftofficeopt%==3 (
    echo Use this key:
    echo KGFVY-7733B-8WCK9-KTG64-BC7D8
    echo Press any key to exit...
    pause > nul
    exit /B
)

goto error4