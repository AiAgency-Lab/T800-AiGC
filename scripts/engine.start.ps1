$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$engineRoot = Split-Path -Parent $scriptRoot

$python = "python"

$services = @(
    @{
        Name   = "EHF"
        Path   = Join-Path $engineRoot "engine_core\ehf\ehf_dashboard.py"
        Port   = 9001
        Args   = ""
    },
    @{
        Name   = "TRON"
        Path   = Join-Path $engineRoot "engine_core\tron\tron_rhythm.py"
        Port   = 9000
        Args   = ""
    },
    @{
        Name   = "ZHA"
        Path   = Join-Path $engineRoot "engine_core\zha\zha_unified.py"
        Port   = 9000
        Args   = ""
    }
)

Write-Host "=== ENGINE START ===" -ForegroundColor Cyan

foreach ($svc in $services) {
    if (Test-Path $svc.Path) {
        Write-Host ("Starting {0}..." -f $svc.Name) -ForegroundColor Green
        Start-Process -FilePath $python -ArgumentList "`"$($svc.Path)`" $($svc.Args)" -WorkingDirectory (Split-Path -Parent $svc.Path) -WindowStyle Minimized
    } else {
        Write-Host ("[SKIP] {0} (missing: {1})" -f $svc.Name, $svc.Path) -ForegroundColor Yellow
    }
}

Start-Sleep -Seconds 3

Write-Host "Running mesh status..." -ForegroundColor Cyan
& "$scriptRoot\mesh.ps1"

if (Test-Path (Join-Path $scriptsDir "agent.ps1")) {
    Write-Host "Starting agent..." -ForegroundColor Cyan
    & "$scriptRoot\agent.ps1"
} else {
    Write-Host "[SKIP] agent (agent.ps1 not found)" -ForegroundColor Yellow
}
