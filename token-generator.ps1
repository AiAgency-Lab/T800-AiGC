# --- Sovereign Mesh Token Generator ---

Write-Host "`n[ Mesh Token Generator ]" -ForegroundColor Cyan

# 1. Locate ecosystem.json
$start = Get-Location
$ecosystemFile = $null

while ($start -ne $null -and -not $ecosystemFile) {
    $candidate = Join-Path $start "ecosystem.json"
    if (Test-Path $candidate) { $ecosystemFile = $candidate; break }
    $start = Split-Path $start -Parent
}

if (-not $ecosystemFile) {
    Write-Host "ecosystem.json not found." -ForegroundColor Red
    return
}

$ecosystem = Get-Content $ecosystemFile -Raw | ConvertFrom-Json

# 2. Generate entropy + identity event
$entropy = -join ((48..57) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})
$timestamp = (Get-Date).ToString("yyyyMMddHHmmss")
$signature = "$entropy-$timestamp"

# 3. Create new identity node
$newNode = [PSCustomObject]@{
    id          = "node_token_$timestamp"
    type        = "token"
    name        = "Mesh Identity Token"
    signature   = $signature
    coordinates = "1,1,0"
    slot        = "slot_token_001"
    wallet      = "unassigned"
}

# 4. Append to ecosystem
$ecosystem.systems += $newNode

# 5. Save ecosystem.json
$ecosystem | ConvertTo-Json -Depth 10 | Set-Content $ecosystemFile

Write-Host "`n[+] Token generated." -ForegroundColor Green
Write-Host "[+] NodeID: $($newNode.id)"
Write-Host "[+] Signature: $signature"
Write-Host "[+] Coordinates: $($newNode.coordinates)"
Write-Host "[+] Written to ecosystem.json"
