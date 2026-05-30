param([string]$Target, [string]$Payload)

switch ($Target.ToLower()) {
    "lucy"  { & "$PSScriptRoot\..\scripts\lucy.ps1" -InputText $Payload }
    "lucky" { & "$PSScriptRoot\..\scripts\lucky.ps1" }
    default { Write-Host "[Mesh] Unknown target: $Target" -ForegroundColor Red }
}
