param(
    [string]$MeshFile = "mesh.map.json"
)

if (!(Test-Path $MeshFile)) {
    Write-Host "Mesh file not found: $MeshFile" -ForegroundColor Red
    exit
}

$mesh = Get-Content $MeshFile | ConvertFrom-Json

Write-Host "`n=== MESH INSPECTOR ===" -ForegroundColor Cyan
Write-Host "Loaded: $MeshFile"

Write-Host "`n[NODES]" -ForegroundColor Yellow
foreach ($n in $mesh.nodes) {
    Write-Host " - $($n.id)  kind=$($n.kind)"
}

Write-Host "`n[EDGES]" -ForegroundColor Yellow
foreach ($e in $mesh.edges) {
    Write-Host " - $($e.from)  $($e.to)  ($($e.type))"
}

Write-Host "`n[OK] Inspection complete." -ForegroundColor Green
