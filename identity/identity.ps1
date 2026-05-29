# --- IDENTITY LAYER (Bex Logic) ---
\ = Get-Content "..\mesh\mesh.map.json" | ConvertFrom-Json

\ = @{
    machine   = \AIAGENCY101
    user      = \Admin
    root      = (Get-Location).Path
    timestamp = (Get-Date).ToString("o")
    nodes     = \.nodes
}

\ | ConvertTo-Json -Depth 10 | Out-File ".\identity.json"
Write-Host "Identity layer written to identity.json"
