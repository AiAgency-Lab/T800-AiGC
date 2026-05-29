Write-Host "`n=== SOVEREIGN COMPUTE ACTIVATION ===" -ForegroundColor Cyan

Write-Host "`n Identity Sync"
powershell -ExecutionPolicy Bypass -File identity.ps1

Write-Host "`n Mesh Generation"
powershell -ExecutionPolicy Bypass -File mesh.ps1

Write-Host "`n Mesh Inspection"
powershell -ExecutionPolicy Bypass -File mesh-inspector.ps1

Write-Host "`n ASCII View"
powershell -ExecutionPolicy Bypass -File mesh-ascii.ps1

Write-Host "`n 3D View"
powershell -ExecutionPolicy Bypass -File mesh-3d.ps1

Write-Host "`n=== SYSTEM ONLINE ===" -ForegroundColor Green
