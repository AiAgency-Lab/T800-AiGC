param(
    [string]$Root = (Get-Location).Path,
    [string]$OutputJson = "mesh.map.json"
)

Write-Host "Scanning for Git repositories under: $Root"

$gitDirs = Get-ChildItem -Path $Root -Recurse -Directory -ErrorAction SilentlyContinue |
    Where-Object { Test-Path (Join-Path $_.FullName ".git") }

$nodes = @()
$edges = @()

foreach ($dir in $gitDirs) {
    $nodes += [pscustomobject]@{
        id   = $dir.Name
        path = $dir.FullName
        kind = "repo"
    }
}

$groups = $nodes | Group-Object { Split-Path $_.path -Parent }

foreach ($g in $groups) {
    $items = $g.Group
    if ($items.Count -gt 1) {
        for ($i = 0; $i -lt $items.Count; $i++) {
            for ($j = $i + 1; $j -lt $items.Count; $j++) {
                $edges += [pscustomobject]@{
                    from = $items[$i].id
                    to   = $items[$j].id
                    type = "SharedParent"
                }
            }
        }
    }
}

$machineId   = "machine_$($env:COMPUTERNAME)"
$machineNode = [pscustomobject]@{
    id            = $machineId
    kind          = "machine"
    hostname      = $env:COMPUTERNAME
    windowsUser   = $env:USERNAME
    windowsDomain = $env:USERDOMAIN
    path          = $Root
}
$nodes += $machineNode

$mesh = [pscustomobject]@{
    root  = $Root
    nodes = $nodes
    edges = $edges
}

$mesh | ConvertTo-Json -Depth 10 | Set-Content -Path $OutputJson -Encoding UTF8
Write-Host "Mesh JSON written to: $OutputJson"
