@echo off
echo SFC(Again)
sfc /scannow
echo Rebooting(After reboot please sign in again and you will be done)
timeout 10
start /min 2(1).bat
timeout 2
shutdown -r /t 0
