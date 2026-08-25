@echo off
cd /d "%~dp0"
echo Fetching Stoat logs (Press Ctrl+C to exit)...
docker compose logs -f
