Write-Host "`n[ Identity Sync ]" -ForegroundColor Cyan

$ecosystem = Get-Content ".\ecosystem.json" -Raw | ConvertFrom-Json

if (-not $ecosystem.systems) {
    Write-Host "No system surfaces defined in ecosystem.json"
    return
}

foreach ($sys in $ecosystem.systems) {
    Write-Host "`n--- Resolving $($sys.name) ---" -ForegroundColor Yellow
    Write-Host "NodeID      : $($sys.id)"
    Write-Host "Type        : $($sys.type)"
    Write-Host "Coordinates : $($sys.coordinates)"
    Write-Host "Slot        : $($sys.slot)"
    Write-Host "Signature   : $($sys.signature)"
}
