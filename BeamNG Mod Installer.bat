@echo off
title BeamNG Mod Installer
mkdir "%userprofile%\Desktop\Input Mods"
echo Please put your mods into the folder on the desktop named "Input mods"
echo Press any key to copy
pause > nul
robocopy "%userprofile%\Desktop\Input Mods" "C:\Users\denby\AppData\Local\BeamNG.drive\0.25\mods" 
robocopy "%userprofile%\Desktop\Input Mods" "F:\BeamNG\All Of Them" 
echo 1=Yes
echo 2=No
set /p option=Would you like to put these mods in the "Quality mods" folder?-
if %option%==1 robocopy "%userprofile%\Desktop\Input Mods" "F:\BeamNG\Normal Quality Mods\mods" 
if %option%==y robocopy "%userprofile%\Desktop\Input Mods" "F:\BeamNG\Normal Quality Mods\mods" 
if %option%==Y robocopy "%userprofile%\Desktop\Input Mods" "F:\BeamNG\Normal Quality Mods\mods" 
if %option%==yes robocopy "%userprofile%\Desktop\Input Mods" "F:\BeamNG\Normal Quality Mods\mods" 
if %option%==Yes robocopy "%userprofile%\Desktop\Input Mods" "F:\BeamNG\Normal Quality Mods\mods" 
rmdir /s /q "%userprofile%\Desktop\Input Mods"
pause

pause
