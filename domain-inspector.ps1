param([string]$domain)

$root = "C:\(   .   Y    .   )ENGINE"

$domains = Get-Content "$root\registry\domains.json" | ConvertFrom-Json
$nodes   = Get-Content "$root\mesh\nodes.json" | ConvertFrom-Json
$slots   = Get-Content "$root\slots\index.json" | ConvertFrom-Json
$map     = Get-Content "$root\slots\map.json" | ConvertFrom-Json
$owner   = Get-Content "$root\slots\ownership.json" | ConvertFrom-Json

$d = $domains.domains | Where-Object { $_.name -eq $domain }
$s = $slots.slots | Where-Object { $_.domain -eq $domain }
$n = $nodes.nodes | Where-Object { $_.domain -eq $domain }

$coord = $map.slot_map."$($s.slot_id)"
$wallet = $owner.ownership."$($s.slot_id)"

[PSCustomObject]@{
    Domain      = $domain
    Slot        = $s.slot_id
    Coordinates = $coord
    NodeID      = $n.id
    Wallet      = $wallet
}
