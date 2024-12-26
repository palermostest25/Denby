@echo off
set 1=%1
if not defined 1 echo -s for Slui, -c for Certutil && pause
if %1==-s slui 0x2a %2
if %1==-c certutil -error %2