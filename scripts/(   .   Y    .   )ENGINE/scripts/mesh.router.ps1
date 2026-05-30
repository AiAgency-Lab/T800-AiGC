param([string]$Target, [string]$Payload)
switch ($Target.ToLower()) {
    "lucy"  { & "$PSScriptRoot\lucy.ps1" -InputText $Payload }
    "lucky" { & "$PSScriptRoot\lucky.ps1" }
    default { Write-Host "[Mesh] Unknown target: $Target" -ForegroundColor Red }
}
