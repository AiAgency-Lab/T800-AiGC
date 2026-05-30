function Invoke-MeshHeartbeat {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    $services = @(
        @{ Name = "EHF Dashboard"; Url = "http://localhost:9001/api/ehf/status" },
        @{ Name = "TRON Rhythm";   Url = "http://localhost:9000/api/tron/status" },
        @{ Name = "ZHA Unified";   Url = "http://localhost:9000/api/zha/status" }
    )

    Write-Host ""
    Write-Host "=== MESH HEARTBEAT ===" -ForegroundColor Cyan

    foreach ($s in $services) {
        try {
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            $r  = Invoke-WebRequest -Uri $s.Url -Method GET -TimeoutSec 3
            $sw.Stop()
            if ($r.StatusCode -ge 200 -and $r.StatusCode -lt 400) {
                Write-Host ("[UP]   {0,-16} {1,6} ms" -f $s.Name, [math]::Round($sw.Elapsed.TotalMilliseconds,1)) -ForegroundColor Green
            } else {
                Write-Host ("[DOWN] {0}" -f $s.Name) -ForegroundColor Red
            }
        } catch {
            Write-Host ("[DOWN] {0}" -f $s.Name) -ForegroundColor Red
        }
    }

    Write-Host ""
}
