# --- ACTIVATION LAYER (Bex Logic) ---
\ = Get-Content "..\identity\identity.json" | ConvertFrom-Json

Write-Host "Activating mesh for \ as \..."

foreach (\ in \.nodes) {
    Write-Host "Activating node: \"
}

\ = @{
    active    = \True
    timestamp = (Get-Date).ToString("o")
    machine   = \.machine
    nodes     = \.nodes.Count
}

\ | ConvertTo-Json -Depth 10 | Out-File ".\activation.json"
Write-Host "Mesh activation complete."
