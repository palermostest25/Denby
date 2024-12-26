@echo off

title Windows 11 PXE Updater

echo Deleting Windows.iso
del C:\Users\denby\Desktop\PXE\Windows.iso
echo Downloading Script
powershell -NoProfile -Command "Invoke-WebRequest https://raw.githubusercontent.com/pbatard/Fido/refs/heads/master/Fido.ps1 -OutFile C:\Users\denby\Desktop\PXE\Fido.ps1"

echo Setting Download Path
SetLocal
cd /d %~dp0
Set "OldString=[regex]::Match($Url, $pattern).Groups[1].Value"
Set "NewString="Windows.iso""
set file="C:\Users\denby\Desktop\PXE\Fido.ps1"
for %%F in (%file%) do set outFile="C:\Users\denby\Desktop\PXE\FidoUpdated.ps1"
(
  for /f "skip=2 delims=" %%a in ('find /n /v "" %file%') do (
    set "ln=%%a"
    setlocal enableDelayedExpansion
    set "ln=!ln:*]=!"
    if defined ln set "ln=!ln:%OldString%=%NewString%!"
    echo(!ln!
    endlocal
  )
)>%outFile%

echo Calling Fido
powershell -NoProfile C:\Users\denby\Desktop\PXE\FidoUpdated.ps1 -Win 11 -Ed Edu -Lang Eng -Arch x64

if exist C:\Users\denby\Desktop\PXE\Windows.iso (
    echo Creating Empty Directory
    mkdir C:\Users\denby\Desktop\PXE\Empty

    echo Overwriting win11 Folder
    robocopy /mir C:\Users\denby\Desktop\PXE\Empty C:\Users\denby\Desktop\PXE\win11
)

echo Extracting ISO Using 7-Zip
"C:\Program Files\7-Zip\7z.exe" x "C:\Users\denby\Desktop\PXE\Windows.iso" -o"C:\Users\denby\Desktop\PXE\win11"

echo Writing Customisations
echo for %%s in (sCPU sSecureBoot sTPM) do reg add HKLM\SYSTEM\Setup\LabConfig /f /v Bypas%%sCheck /d 1 /t reg_dword > "C:\Users\denby\Desktop\PXE\win11\bypass.cmd"

echo Copying to Images-Updated Directory
xcopy /y "C:\Users\denby\Desktop\PXE\Windows.iso" "Y:\Windows.iso"

echo ---------- DONE ----------
timeout 30