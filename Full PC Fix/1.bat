@echo off
echo DISM
DISM /Online /Cleanup-Image /Restorehealth
copy 2.bat %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
echo Rebooting(After reboot please sign in again)
timeout 10
start /min 1(1).bat
timeout 2
shutdown -r /t 0
