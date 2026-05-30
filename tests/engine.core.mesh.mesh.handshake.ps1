vfunction Invoke-MeshHandshake {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    Write-Host ""
    Write-Host "=== MESH HANDSHAKE ===" -ForegroundColor Cyan

    $peersFile = Join-Path $EngineRoot "config\mesh.peers.json"

    if (Test-Path $peersFile) {
        try {
            $peers = Get-Content $peersFile -Raw | ConvertFrom-Json
            if ($peers -and $peers.Count -gt 0) {
                foreach ($p in $peers) {
                    Write-Host ("Peer: {0} ({1})" -f $p.name, $p.url)
                }
            } else {
                Write-Host "No peers defined."
            }
        } catch {
            Write-Host "Invalid mesh.peers.json format." -ForegroundColor Yellow
        }
    } else {
        Write-Host "No mesh.peers.json found. (config\mesh.peers.json)" -ForegroundColor DarkGray
    }

    Write-Host ""
}
