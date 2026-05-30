$ErrorActionPreference = "Stop"

Write-Host "=== ENGINE STOP ===" -ForegroundColor Cyan

$patterns = @("ehf_dashboard.py","tron_rhythm.py","zha_unified.py","engine_agent.py")

foreach ($p in $patterns) {
    Get-Process | Where-Object { $_.Path -like "*$p" } | ForEach-Object {
        Write-Host ("Stopping {0} ({1})" -f $_.ProcessName, $_.Path) -ForegroundColor Yellow
        Stop-Process -Id $_.Id -Force
    }
}
