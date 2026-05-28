$root = "C:\(   .   Y    .   )ENGINE"

$slots = Get-Content "$root\slots\index.json" | ConvertFrom-Json
$map   = Get-Content "$root\slots\map.json" | ConvertFrom-Json
$owner = Get-Content "$root\slots\ownership.json" | ConvertFrom-Json

Write-Host "`n=== SLOT INSPECTOR ===" -ForegroundColor Green

foreach ($s in $slots.slots) {
    $slotId = $s.slot_id
    $coord  = $map.slot_map."$slotId"
    $wallet = $owner.ownership."$slotId"

    [PSCustomObject]@{
        Slot        = $slotId
        Domain      = $s.domain
        Coordinates = $coord
        Wallet      = $wallet
    }
}
