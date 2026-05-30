param(
    [ValidateSet("register","list","status","load","save")]
    [string]$Action,
    [string]$NodeName,
    [string]$NodeType = "generic",
    [string]$NodeStatus = "online"
)

$RegistryPath = "$PSScriptRoot\mesh.registry.json"

if (Test-Path $RegistryPath) {
    $global:MeshRegistry = Get-Content $RegistryPath | ConvertFrom-Json
} else {
    $global:MeshRegistry = @()
}

switch ($Action) {
    "register" {
        $entry = @{
            Name   = $NodeName
            Type   = $NodeType
            Status = $NodeStatus
            Time   = (Get-Date)
        }
        $global:MeshRegistry += $entry
        Write-Host "[Mesh] Registered: $NodeName" -ForegroundColor Cyan
    }
    "list"   { $global:MeshRegistry | Format-Table }
    "status" {
        $node = $global:MeshRegistry | Where-Object { $_.Name -eq $NodeName }
        if ($node) { $node | Format-List }
        else { Write-Host "[Mesh] Node not found: $NodeName" -ForegroundColor Red }
    }
    "save" {
        $global:MeshRegistry | ConvertTo-Json -Depth 5 | Out-File $RegistryPath -Encoding UTF8
        Write-Host "[Mesh] Registry saved." -ForegroundColor Green
    }
    "load" {
        if (Test-Path $RegistryPath) {
            $global:MeshRegistry = Get-Content $RegistryPath | ConvertFrom-Json
            Write-Host "[Mesh] Registry loaded." -ForegroundColor Green
        } else {
            Write-Host "[Mesh] No registry file found." -ForegroundColor Red
        }
    }
}
