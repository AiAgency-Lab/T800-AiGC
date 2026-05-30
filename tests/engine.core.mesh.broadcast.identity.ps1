function Invoke-MeshBroadcastIdentity {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    $configFile = Join-Path $EngineRoot "config\engine.settings.json"
    $nodeId     = "YCUL-LOCAL"
    $env        = "local"

    if (Test-Path $configFile) {
        try {
            $cfg = Get-Content $configFile -Raw | ConvertFrom-Json
            if ($cfg.node_id) { $nodeId = $cfg.node_id }
            if ($cfg.environment) { $env = $cfg.environment }
        } catch { }
    }

    Write-Host ""
    Write-Host "=== MESH IDENTITY BROADCAST ===" -ForegroundColor Cyan
    Write-Host ("Node: {0}" -f $nodeId)
    Write-Host ("Env : {0}" -f $env)
    Write-Host ("Root: {0}" -f $EngineRoot)
    Write-Host ""
}
