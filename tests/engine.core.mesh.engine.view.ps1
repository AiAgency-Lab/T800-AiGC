function Invoke-EngineView {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    Write-Host ""
    Write-Host "=== ENGINE VIEW ===" -ForegroundColor Cyan
    Write-Host ("Root: {0}" -f $EngineRoot)
    Write-Host ""

    Invoke-MeshHeartbeat
    Invoke-MeshPulse
    Invoke-MeshLattice
}
