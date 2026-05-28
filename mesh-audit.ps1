$root = "C:\(   .   Y    .   )ENGINE"

$domains = Get-Content "$root\registry\domains.json" | ConvertFrom-Json
$nodes   = Get-Content "$root\mesh\nodes.json" | ConvertFrom-Json
$slots   = Get-Content "$root\slots\index.json" | ConvertFrom-Json
$map     = Get-Content "$root\slots\map.json" | ConvertFrom-Json
$owner   = Get-Content "$root\slots\ownership.json" | ConvertFrom-Json

Write-Host "`n=== MESH AUDIT ===" -ForegroundColor Yellow

foreach ($s in $slots.slots) {
    $slotId = $s.slot_id
    $coord  = $map.slot_map."$slotId"
    $wallet = $owner.ownership."$slotId"
    $node   = $nodes.nodes | Where-Object { $_.domain -eq $s.domain }

    if (-not $wallet) { Write-Host "Missing wallet: $slotId ($($s.domain))" -ForegroundColor Red }
    if (-not $coord)  { Write-Host "Missing coordinates: $slotId ($($s.domain))" -ForegroundColor Red }
    if (-not $node)   { Write-Host "Missing node: $slotId ($($s.domain))" -ForegroundColor Red }
}

Write-Host "`nAudit complete." -ForegroundColor Green
