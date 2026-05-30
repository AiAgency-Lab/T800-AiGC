param([int]$Iterations = 3)
for ($i = 1; $i -le $Iterations; $i++) {
    Write-Host "[Lucky] Tick $i" -ForegroundColor Yellow
    Start-Sleep -Seconds 1
}
