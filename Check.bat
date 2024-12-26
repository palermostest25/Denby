@echo off
SFC /ScanNow
DISM /Online /Cleanup-Image /RestoreHealth
SFC /ScanNow