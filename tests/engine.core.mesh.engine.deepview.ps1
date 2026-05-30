function Invoke-EngineDeepView {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    Write-Host ""
    Write-Host "=== ENGINE DEEPVIEW ===" -ForegroundColor Cyan
    Write-Host ("Root: {0}" -f $EngineRoot)
    Write-Host ""

    Invoke-MeshHeartbeat
    Invoke-MeshPulse
    Invoke-MeshLattice
    Invoke-MeshHorizon
    Invoke-MeshBroadcastIdentity
    Invoke-MeshHandshake
}
