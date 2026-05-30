function Invoke-MeshLattice {
    param(
        [switch]$Json
    )

    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    $nodes = @(
        @{ Name = "EHF Dashboard";   Key = "ehf";   Url = "http://localhost:9001/api/ehf/status" },
        @{ Name = "TRON Rhythm";     Key = "tron";  Url = "http://localhost:9000/api/tron/status" },
        @{ Name = "ZHA Unified";     Key = "zha";   Url = "http://localhost:9000/api/zha/status" },
        @{ Name = "Prometheus";      Key = "prom";  Url = "http://localhost:9090/-/ready" },
        @{ Name = "Grafana";         Key = "graf";  Url = "http://localhost:3000/api/health" },
        @{ Name = "Jaeger";          Key = "jaeger";Url = "http://localhost:16686" }
    )

    function Test-MeshNode {
        param(
            [string]$Name,
            [string]$Key,
            [string]$Url
        )

        $result = [ordered]@{
            name    = $Name
            key     = $Key
            url     = $Url
            status  = "DOWN"
            latency = $null
        }

        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        try {
            $resp = Invoke-WebRequest -Uri $Url -Method GET -TimeoutSec 3
            $sw.Stop()
            if ($resp.StatusCode -ge 200 -and $resp.StatusCode -lt 400) {
                $result.status  = "UP"
                $result.latency = [math]::Round($sw.Elapsed.TotalMilliseconds, 1)
            }
        } catch {
            $sw.Stop()
        }

        [pscustomobject]$result
    }

    $lattice = @()
    foreach ($n in $nodes) {
        $lattice += Test-MeshNode -Name $n.Name -Key $n.Key -Url $n.Url
    }

    if ($Json) {
        $lattice | ConvertTo-Json -Depth 4
        return
    }

    Write-Host ""
    Write-Host "=== MESH LATTICE SYNC ===" -ForegroundColor Cyan
    Write-Host ""

    $lattice | Sort-Object name | ForEach-Object {
        $color = if ($_.status -eq "UP") { "Green" } else { "Red" }
        $lat   = if ($_.latency) { ("{0} ms" -f $_.latency) } else { "-" }
        Write-Host ("[{0}] {1,-18} {2,-4} {3}" -f $_.key, $_.name, $_.status, $lat) -ForegroundColor $color
    }

    Write-Host ""
}
