Write-Host "=== ENGINE VIEW ===" -ForegroundColor Cyan
& "$PSScriptRoot\heartbeat.ps1"
& "$PSScriptRoot\pulse.ps1"
& "$PSScriptRoot\lattice.sync.ps1"
