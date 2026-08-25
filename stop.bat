@echo off
cd /d "%~dp0"
echo Stopping Stoat containers...
docker compose down
pause
