Write-Host "=== ENGINE DEEPVIEW ===" -ForegroundColor Cyan
& "$PSScriptRoot\heartbeat.ps1"
& "$PSScriptRoot\pulse.ps1"
& "$PSScriptRoot\lattice.sync.ps1"
& "$PSScriptRoot\horizon.ps1"
& "$PSScriptRoot\broadcast.identity.ps1"
& "$PSScriptRoot\mesh.handshake.ps1"
