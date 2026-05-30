function Invoke-MeshPulse {
    $Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
    $EngineRoot = Split-Path -Parent $Self

    Write-Host ""
    Write-Host "=== MESH PULSE (LOCAL SERVICES) ===" -ForegroundColor Cyan

    $ports =  @(
        @{ Name = "EHF Dashboard"; Port = 9001 },
        @{ Name = "TRON / ZHA API"; Port = 9000 },
        @{ Name = "Prometheus"; Port = 9090 },
        @{ Name = "Grafana"; Port = 3000 },
        @{ Name = "Jaeger"; Port = 16686 }
    )

    foreach ($p in $ports) {
        $tcp = New-Object System.Net.Sockets.TcpClient
        try {
            $tcp.Connect("localhost", $p.Port)
            if ($tcp.Connected) {
                Write-Host ("[OPEN] {0,-16} :{1}" -f $p.Name, $p.Port) -ForegroundColor Green
            } else {
                Write-Host ("[CLOSED] {0,-16} :{1}" -f $p.Name, $p.Port) -ForegroundColor Red
            }
        } catch {
            Write-Host ("[CLOSED] {0,-16} :{1}" -f $p.Name, $p.Port) -ForegroundColor Red
        } finally {
            $tcp.Close()
        }
    }

    Write-Host ""
}
