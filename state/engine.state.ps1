# --- ENGINE STATE VIEWER ---

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$meshPath       = Join-Path $root "..\mesh.map.json"
$rolesPath      = Join-Path $root "..\mesh.roles.json"
$activationPath = Join-Path $root "..\activation.state.json"
$pulsePath      = Join-Path $root "..\pulse.state.json"
$resPath        = Join-Path $root "..\resonance.state.json"
$wrapPath       = Join-Path $root "..\activation.wrap.json"

$state = @{}

if (Test-Path $meshPath)       { $state.mesh       = Get-Content $meshPath       | ConvertFrom-Json }
if (Test-Path $rolesPath)      { $state.roles      = Get-Content $rolesPath      | ConvertFrom-Json }
if (Test-Path $activationPath) { $state.activation = Get-Content $activationPath | ConvertFrom-Json }
if (Test-Path $pulsePath)      { $state.pulse      = Get-Content $pulsePath      | ConvertFrom-Json }
if (Test-Path $resPath)        { $state.resonance  = Get-Content $resPath        | ConvertFrom-Json }
if (Test-Path $wrapPath)       { $state.wrap       = Get-Content $wrapPath       | ConvertFrom-Json }

$state.model_state = "ACTIVE"

$statePath = Join-Path $root "engine.state.json"
$state | ConvertTo-Json -Depth 10 | Out-File $statePath

Write-Host "Engine state set to ACTIVE"
