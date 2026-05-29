# --- Sovereign Mesh Inspector ---

Write-Host "`n[ Sovereign Mesh Inspector ]" -ForegroundColor Cyan

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

$root = Split-Path $ecosystemFile -Parent
$meshFolder = Join-Path $root "mesh"
$gridFile  = Join-Path $meshFolder "grid.json"
$linksFile = Join-Path $meshFolder "links.json"

# 2. Load ecosystem
$ecosystem = Get-Content $ecosystemFile -Raw | ConvertFrom-Json

# 3. Load grid + links if present
$grid  = if (Test-Path $gridFile)  { Get-Content $gridFile  -Raw | ConvertFrom-Json } else { @() }
$links = if (Test-Path $linksFile) { Get-Content $linksFile -Raw | ConvertFrom-Json } else { @() }

# ---------------------------------------------------------
# SECTION 1  NODE LIST
# ---------------------------------------------------------
Write-Host "`n=== NODE LIST ===" -ForegroundColor Yellow

foreach ($sys in $ecosystem.systems) {
    "{0,-25} | {1,-10} | {2}" -f $sys.id, $sys.type, $sys.name
}

# ---------------------------------------------------------
# SECTION 2  GRID VIEW
# ---------------------------------------------------------
Write-Host "`n=== GRID VIEW ===" -ForegroundColor Yellow

if ($grid.Count -eq 0) {
    Write-Host "No grid.json found."
} else {
    foreach ($n in $grid | Sort-Object z,y,x) {
        "{0,2},{1,2},{2,2} | {3,-10} | {4}" -f $n.x,$n.y,$n.z,$n.type,$n.name
    }
}

# ---------------------------------------------------------
# SECTION 3  LINK VIEW
# ---------------------------------------------------------
Write-Host "`n=== LINK VIEW ===" -ForegroundColor Yellow

if ($links.Count -eq 0) {
    Write-Host "No links.json found."
} else {
    foreach ($l in $links) {
        "{0} --({2})-> {1}" -f $l.from,$l.to,$l.type
    }
}

# ---------------------------------------------------------
# SECTION 4  RESOLVED OUTPUT (calls identity-sync)
# ---------------------------------------------------------
Write-Host "`n=== RESOLVED OUTPUT ===" -ForegroundColor Yellow

$syncScript = Join-Path $root "identity-sync.ps1"
if (Test-Path $syncScript) {
    & $syncScript
} else {
    Write-Host "identity-sync.ps1 not found."
}

Write-Host "`n[ Mesh Inspection Complete ]" -ForegroundColor Green
