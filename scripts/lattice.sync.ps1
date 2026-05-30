Write-Host "=== LATTICE ===" -ForegroundColor Cyan
$nodes = @(
    @{Name="EHF"; Url="http://localhost:9001/api/ehf/status"},
    @{Name="TRON"; Url="http://localhost:9000/api/tron/status"},
    @{Name="ZHA"; Url="http://localhost:9000/api/zha/status"}
)
foreach ($n in $nodes) {
    try {
        $sw=[Diagnostics.Stopwatch]::StartNew()
        $r=Invoke-WebRequest -Uri $n.Url -TimeoutSec 2
        $sw.Stop()
        Write-Host "[UP]   $($n.Name) $([math]::Round($sw.Elapsed.TotalMilliseconds,1))ms" -ForegroundColor Green
    } catch {
        Write-Host "[DOWN] $($n.Name)" -ForegroundColor Red
    }
}
