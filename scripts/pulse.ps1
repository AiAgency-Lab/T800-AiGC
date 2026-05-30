Write-Host "=== PULSE ===" -ForegroundColor Cyan
$ports = @(9000,9001,3000,9090,16686)
foreach ($p in $ports) {
    $tcp = New-Object System.Net.Sockets.TcpClient
    try {
        $tcp.Connect("localhost",$p)
        Write-Host "[OPEN]  :$p" -ForegroundColor Green
    } catch {
        Write-Host "[CLOSED]:$p" -ForegroundColor Red
    }
    $tcp.Close()
}
