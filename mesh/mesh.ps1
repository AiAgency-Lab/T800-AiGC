# --- MESH SCANNER (Bex Logic) ---
\C:\(   .   Y    .   )ENGINE = Get-Location
Write-Host "Scanning for Git repositories under: \C:\(   .   Y    .   )ENGINE"

\ = Get-ChildItem -Recurse -Directory -Force |
    Where-Object { Test-Path (Join-Path \.FullName ".git") }

\ = @()
\ = @()

foreach (\ in \) {
    \ += @{
        name = \.Name
        path = \.FullName
    }

    \ += @{
        from = \C:\(   .   Y    .   )ENGINE.Path
        to   = \.FullName
    }
}

\ = @{
    root  = \C:\(   .   Y    .   )ENGINE.Path
    nodes = \
    edges = \
}

\ | ConvertTo-Json -Depth 10 | Out-File ".\mesh.map.json"
Write-Host "Mesh JSON written to: mesh.map.json"
