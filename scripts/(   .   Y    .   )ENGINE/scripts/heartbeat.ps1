param([int]$IntervalSeconds = 5, [int]$Beats = 3)
for ($i = 1; $i -le $Beats; $i++) {
    Write-Host "[Heartbeat] Beat $i" -ForegroundColor Cyan
    Start-Sleep -Seconds $IntervalSeconds
}
