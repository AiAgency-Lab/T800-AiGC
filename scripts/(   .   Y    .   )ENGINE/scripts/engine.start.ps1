Write-Host "[ENGINE] Starting..." -ForegroundColor Green

$root = $PSScriptRoot

& "$root\mesh.registry.ps1" -Action load

& "$root\lucky.ps1" -Iterations 3

$result = & "$root\mesh.router.ps1" -Target "lucy" -Payload "engine boot check"
Write-Host "[ENGINE] Lucy result:" -ForegroundColor Green
$result | Format-List

& "$root\heartbeat.ps1" -IntervalSeconds 2 -Beats 3

Write-Host "[ENGINE] Start sequence complete." -ForegroundColor Green
