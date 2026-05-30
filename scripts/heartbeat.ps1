Write-Host "=== HEARTBEAT ===" -ForegroundColor Cyan
$services = @(
    @{Name="EHF"; Url="http://localhost:9001/api/ehf/status"},
    @{Name="TRON"; Url="http://localhost:9000/api/tron/status"},
    @{Name="ZHA"; Url="http://localhost:9000/api/zha/status"}
)
foreach ($s in $services) {
    try {
        $r = Invoke-WebRequest -Uri $s.Url -TimeoutSec 2
        Write-Host "[UP]   $($s.Name)" -ForegroundColor Green
    } catch {
        Write-Host "[DOWN] $($s.Name)" -ForegroundColor Red
    }
}
