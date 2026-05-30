param([string]$Event, [string]$Payload)

$entry = @{
    Event = $Event
    Payload = $Payload
    Time = (Get-Date)
}

$log = Join-Path $PSScriptRoot "mesh.events.log"
$entry | ConvertTo-Json -Depth 5 | Add-Content $log

Write-Host "[Mesh] Event fired: $Event" -ForegroundColor Yellow
