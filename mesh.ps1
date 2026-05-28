$root = "C:\(   .   Y    .   )ENGINE"

$nodes = Get-Content "$root\mesh\nodes.json" | ConvertFrom-Json
$links = Get-Content "$root\mesh\links.json" | ConvertFrom-Json

Write-Host "`n=== NODES ===" -ForegroundColor Cyan
$nodes.nodes | Format-Table id, domain, wallet, coordinates

Write-Host "`n=== LINKS ===" -ForegroundColor Cyan
$links.links | Format-Table from, to, type
