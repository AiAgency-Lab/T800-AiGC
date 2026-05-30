param([int]$Items = 50)

$root = $PSScriptRoot
$root = Split-Path -Parent $root   # back to ENGINE root

$statePath = Join-Path $root "state\engine.state.json"
$logPath   = Join-Path $root "logs\realworld.log"

if (-not (Test-Path $statePath)) {
    Write-Host "Engine state missing at state\\engine.state.json" -ForegroundColor Red
    exit 1
}

$engine = Get-Content $statePath | ConvertFrom-Json

"[{0}] REALWORLD START Items={1}" -f (Get-Date -Format o), $Items | Add-Content $logPath

$ok = $true
for ($i = 1; $i -le $Items; $i++) {
    if (-not $engine.surrogate -or -not $engine.anchors) {
        $ok = $false
        "[{0}] FAIL: missing surrogate or anchors at item {1}" -f (Get-Date -Format o), $i | Add-Content $logPath
        break
    }
    Start-Sleep -Milliseconds 5
}

if ($ok) {
    "[{0}] REALWORLD PASS" -f (Get-Date -Format o) | Add-Content $logPath
    Write-Host "Real world smoke: PASS" -ForegroundColor Green
} else {
    "[{0}] REALWORLD FAIL" -f (Get-Date -Format o) | Add-Content $logPath
    Write-Host "Real world smoke: FAIL" -ForegroundColor Red
    exit 1
}
