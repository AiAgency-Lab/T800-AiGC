$root = "C:\(   .   Y    .   )ENGINE"

$nodes = Get-Content "$root\mesh\nodes.json" | ConvertFrom-Json
$links = Get-Content "$root\mesh\links.json" | ConvertFrom-Json

Write-Host "`n=== MESH GRAPH (ASCII) ===" -ForegroundColor Yellow

foreach ($n in $nodes.nodes) {
    Write-Host "`n[$($n.id)]" -ForegroundColor Cyan
    Write-Host " Domain: $($n.domain)"
    Write-Host " Wallet: $($n.wallet)"
    Write-Host " Coord : $($n.coordinates)"

    $connected = $links.links | Where-Object { $_.from -eq $n.id -or $_.to -eq $n.id }

    foreach ($c in $connected) {
        Write-Host "   -> $($c.to) ($($c.type))"
    }
}
