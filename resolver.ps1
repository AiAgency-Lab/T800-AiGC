param(
    [string]$domain
)

$root = "C:\(   .   Y    .   )ENGINE"

$domains = Get-Content "$root\registry\domains.json" | ConvertFrom-Json
$nodes   = Get-Content "$root\mesh\nodes.json" | ConvertFrom-Json
$slots   = Get-Content "$root\slots\index.json" | ConvertFrom-Json
$map     = Get-Content "$root\slots\map.json" | ConvertFrom-Json
$owner   = Get-Content "$root\slots\ownership.json" | ConvertFrom-Json

$domainEntry = $domains.domains | Where-Object { $_.name -eq $domain }
if (-not $domainEntry) {
    Write-Output "Domain not found in registry."
    exit
}

$node = $nodes.nodes | Where-Object { $_.domain -eq $domain }
$slot = $slots.slots | Where-Object { $_.domain -eq $domain }

$coord = $map.slot_map."$($slot.slot_id)"
$wallet = $owner.ownership."$($slot.slot_id)"

[PSCustomObject]@{
    Domain      = $domain
    Slot        = $slot.slot_id
    Coordinates = $coord
    NodeID      = $node.id
    Wallet      = $wallet
}
