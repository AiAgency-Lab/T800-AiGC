function Invoke-MeshHorizon {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    Write-Host ""
    Write-Host "=== MESH HORIZON (NEXT ACTIONS) ===" -ForegroundColor Cyan

    $horizonFile = Join-Path $EngineRoot "config\horizon.queue.json"

    if (Test-Path $horizonFile) {
        try {
            $items = Get-Content $horizonFile -Raw | ConvertFrom-Json
            if ($items -and $items.Count -gt 0) {
                $items | ForEach-Object {
                    Write-Host ("- [{0}] {1}" -f $_.priority, $_.title)
                }
            } else {
                Write-Host "No queued horizon items."
            }
        } catch {
            Write-Host "Invalid horizon.queue.json format." -ForegroundColor Yellow
        }
    } else {
        Write-Host "No horizon.queue.json found. (config\horizon.queue.json)" -ForegroundColor DarkGray
    }

    Write-Host ""
}
