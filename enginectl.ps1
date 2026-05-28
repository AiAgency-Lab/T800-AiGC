param(
    [string]$command,
    [string]$arg1
)

$root = "C:\(   .   Y    .   )ENGINE"

function Show-Help {
    Write-Host "`n=== enginectl commands ===" -ForegroundColor Cyan
    Write-Host " resolve <domain>      - Resolve a single domain"
    Write-Host " inspect <domain>      - Full domain inspector"
    Write-Host " audit                 - Mesh audit"
    Write-Host " map                   - Mesh map (2D)"
    Write-Host " nodes                 - List mesh nodes"
    Write-Host " slots                 - List slot assignments"
    Write-Host " engines               - List engines"
    Write-Host " all                   - Resolve all domains"
    Write-Host " help                  - Show this help"
}

switch ($command) {

    "resolve" {
        & "$root\resolver.ps1" $arg1
    }

    "inspect" {
        & "$root\domain-inspector.ps1" $arg1
    }

    "audit" {
        & "$root\mesh-audit.ps1"
    }

    "map" {
        & "$root\mesh-map.ps1"
    }

    "nodes" {
        $nodes = Get-Content "$root\mesh\nodes.json" | ConvertFrom-Json
        $nodes.nodes | Format-Table id, domain, wallet, coordinates
    }

    "slots" {
        $slots = Get-Content "$root\slots\index.json" | ConvertFrom-Json
        $slots.slots | Format-Table slot_id, domain
    }

    "engines" {
        $eng = Get-Content "$root\registry\engines.json" | ConvertFrom-Json
        $eng.engines | Format-Table name, file
    }

    "all" {
        & "$root\resolve-all.ps1"
    }

    "help" {
        Show-Help
    }

    default {
        Show-Help
    }
}
