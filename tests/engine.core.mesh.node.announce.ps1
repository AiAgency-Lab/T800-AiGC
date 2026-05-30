function Invoke-MeshNodeAnnounce {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    $logDir  = Join-Path $EngineRoot "logs"
    $logFile = Join-Path $logDir "mesh.announce.log"

    if (-not (Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir | Out-Null
    }

    $stamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "[{0}] Node announce from {1}" -f $stamp, $EngineRoot

    Add-Content -Path $logFile -Value $entry

    Write-Host ""
    Write-Host "=== NODE ANNOUNCE ===" -ForegroundColor Cyan
    Write-Host $entry
    Write-Host ""
}
