@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1

:: EFI bölümü mount
mountvol X: /S

:: Daha önce yeniden adlandırılan dosyayı eski ismine döndür
if exist "X:\EFI\Microsoft\Boot\boot.efi" (
    move /y "X:\EFI\Microsoft\Boot\boot.efi" "X:\EFI\Microsoft\Boot\bootmgfw.efi"
)

:: Yedekten eski bootx64.efi’yi geri al
if exist "X:\EFI\Boot\bootx64.efi.backup" (
    del /f /q "X:\EFI\Boot\bootx64.efi"
    move /y "X:\EFI\Boot\bootx64.efi.backup" "X:\EFI\Boot\bootx64.efi"
)

:: Eklenen dosyaları temizle
if exist "X:\EFI\Boot\mp.efi" (
    del /f /q "X:\EFI\Boot\mp.efi"
)
if exist "X:\EFI\Boot\startup.nsh" (
    del /f /q "X:\EFI\Boot\startup.nsh"
)


:: EFI bölümü unmount
mountvol X: /D

exit
