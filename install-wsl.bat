@echo off
title Install WSL for Docker Desktop
echo ========================================================
echo        Installing Windows Subsystem for Linux (WSL)
echo ========================================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] This script requires Administrator rights to enable Windows features.
    echo.
    echo Please right-click 'install-wsl.bat' and select:
    echo "Run as administrator" (Kör som administratör)
    echo.
    pause
    exit /b 1
)

echo Installing WSL Linux subsystem components...
wsl.exe --install --no-distribution

echo.
echo ========================================================
echo  WSL installation triggered!
echo ========================================================
echo.
echo If Windows asks to restart your computer, please restart.
echo After rebooting, open Docker Desktop and double-click start.bat!
echo.
pause
