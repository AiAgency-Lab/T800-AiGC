# --- ENGINE STATE (Bex Logic) ---
\ = @{
    engine    = "ACTIVE"
    timestamp = (Get-Date).ToString("o")
}

\ | ConvertTo-Json | Out-File ".\engine.state.json"
Write-Host "Engine state set to ACTIVE"
