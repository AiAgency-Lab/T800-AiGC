Write-Host "[Mesh] Bringing mesh online..." -ForegroundColor Green

$root = $PSScriptRoot

& "$root\mesh.registry.ps1" -Action load

& "$root\mesh.registry.ps1" -Action register -NodeName "mesh" -NodeType "router"
& "$root\mesh.registry.ps1" -Action register -NodeName "events" -NodeType "event-bus"
& "$root\mesh.registry.ps1" -Action register -NodeName "health" -NodeType "monitor"

& "$root\mesh.registry.ps1" -Action save

Write-Host "[Mesh] Online." -ForegroundColor Green
