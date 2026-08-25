# Start Stoat Self-Hosted Stack
try {
    Write-Host "Checking Docker status..." -ForegroundColor Cyan
    & docker info > $null 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Docker Desktop engine is not running." -ForegroundColor Red
        Write-Host "Please start Docker Desktop and ensure the engine is green/ready, then run this script again." -ForegroundColor Yellow
        Read-Host -Prompt "`nPress Enter to exit..."
        exit 1
    }

    Write-Host "Starting Stoat containers..." -ForegroundColor Green
    & docker compose up -d

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n========================================================" -ForegroundColor Green
        Write-Host " Stoat is RUNNING!" -ForegroundColor Green
        Write-Host " Public URL: https://lung-acrylic-studied-indie.trycloudflare.com" -ForegroundColor Cyan
        Write-Host "========================================================" -ForegroundColor Green
        
        Start-Sleep -Seconds 2
        Start-Process "https://lung-acrylic-studied-indie.trycloudflare.com"
    } else {
        Write-Host "[ERROR] Failed to start Docker Compose stack." -ForegroundColor Red
    }
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

Read-Host -Prompt "`nPress Enter to exit..."
