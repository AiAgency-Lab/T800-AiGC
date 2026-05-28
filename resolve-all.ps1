$root = "C:\(   .   Y    .   )ENGINE"

$domains = Get-Content "$root\registry\domains.json" | ConvertFrom-Json

foreach ($d in $domains.domains) {
    Write-Host "`n--- Resolving $($d.name) ---" -ForegroundColor Cyan
    & "$root\resolver.ps1" $d.name
}
