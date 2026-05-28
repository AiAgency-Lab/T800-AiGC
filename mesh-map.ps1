$root = "C:\(   .   Y    .   )ENGINE"

$slots = Get-Content "$root\slots\index.json" | ConvertFrom-Json
$map   = Get-Content "$root\slots\map.json" | ConvertFrom-Json

Write-Host "`n=== MESH MAP (2D) ===" -ForegroundColor Cyan

foreach ($s in $slots.slots) {
    $slotId = $s.slot_id
    $coord  = $map.slot_map."$slotId"
    Write-Host "$slotId ($($s.domain)) -> $coord"
}
