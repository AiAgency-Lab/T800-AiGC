param(
    [string]$engine
)

$root = "C:\(   .   Y    .   )ENGINE"

$engines = Get-Content "$root\registry\engines.json" | ConvertFrom-Json
$entry = $engines.engines | Where-Object { $_.name -eq $engine }

if (-not $entry) {
    Write-Output "Engine not found."
    exit
}

$file = Join-Path $root "engines\$($entry.file | Split-Path -Leaf)"
$content = Get-Content $file | ConvertFrom-Json

Write-Host "`n=== ENGINE: $engine ===" -ForegroundColor Magenta
$content
