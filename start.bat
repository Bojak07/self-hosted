@echo off
setlocal enabledelayedexpansion
title Stoat Launcher

echo ========================================================
echo                 Stoat Self-Hosted Launcher
echo ========================================================
echo.

:: Add Docker Desktop paths to PATH in case environment hasn't reloaded
set "PATH=%LOCALAPPDATA%\Programs\DockerDesktop\resources\bin;C:\Program Files\Docker\Docker\resources\bin;%PATH%"

:: Check if docker is installed
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] Docker Desktop is NOT installed yet on this PC.
    echo.
    echo Launching the Docker Desktop installer for you now...
    echo (Please click 'Yes' on the Windows Administrator / UAC prompt!)
    echo.
    if exist "%USERPROFILE%\Downloads\Docker Desktop Installer.exe" (
        start "" "%USERPROFILE%\Downloads\Docker Desktop Installer.exe"
    ) else (
        echo Downloading Docker installer...
        start https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
    )
    echo.
    echo Instructions:
    echo 1. Complete the Docker Desktop installation wizard.
    echo 2. Restart your computer if Windows asks you to.
    echo 3. Launch Docker Desktop from the Start Menu.
    echo 4. Run this start.bat file again once Docker is open!
    echo.
    pause
    exit /b 1
)

:: Check if docker daemon is running
echo Checking if Docker engine is running...
docker info >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] Docker Desktop is installed, but the engine is not running yet.
    echo Starting Docker Desktop...
    if exist "%LOCALAPPDATA%\Programs\DockerDesktop\Docker Desktop.exe" (
        start "" "%LOCALAPPDATA%\Programs\DockerDesktop\Docker Desktop.exe"
    ) else if exist "C:\Program Files\Docker\Docker\Docker Desktop.exe" (
        start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    )
    echo.
    echo Please make sure Docker Desktop is open on your screen and terms are accepted.
    echo Waiting for Docker engine to become ready...
    :wait_docker
    timeout /t 4 /nobreak >nul
    docker info >nul 2>nul
    if %errorlevel% neq 0 (
        echo Still waiting for Docker engine to start...
        goto wait_docker
    )
    echo Docker engine is ready!
)

echo.
echo ========================================================
echo Starting Stoat containers...
echo ========================================================
cd /d "%~dp0"
docker compose up -d

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo  Stoat is RUNNING with Cloudflare Tunnel!
    echo  Public Secure URL: https://lung-acrylic-studied-indie.trycloudflare.com
    echo ========================================================
    echo.
    timeout /t 2 >nul
    start https://lung-acrylic-studied-indie.trycloudflare.com
) else (
    echo.
    echo [ERROR] Failed to start containers. See output above.
)

pause
