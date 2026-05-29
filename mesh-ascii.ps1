param(
    [string]$MeshFile = "mesh.map.json"
)

if (!(Test-Path $MeshFile)) {
    Write-Host "Mesh file not found: $MeshFile" -ForegroundColor Red
    exit
}

$mesh = Get-Content $MeshFile | ConvertFrom-Json

Write-Host "`n=== ASCII MESH VIEW ===" -ForegroundColor Cyan

function Parse-Coords($c) {
    if (-not $c) { return @(0,0,0) }
    return $c -split "," | ForEach-Object { [int]$_ }
}

$points = @()
foreach ($n in $mesh.nodes) {
    $coords = Parse-Coords $n.coordinates
    $points += [pscustomobject]@{
        id   = $n.id
        kind = $n.kind
        x    = $coords[0]
        y    = $coords[1]
        z    = $coords[2]
    }
}

if (-not $points) {
    Write-Host "No nodes to render."
    exit
}

$maxX = ($points.x | Measure-Object -Maximum).Maximum
$maxY = ($points.y | Measure-Object -Maximum).Maximum

$grid = @{}
for ($y = 0; $y -le $maxY; $y++) {
    $row = ""
    for ($x = 0; $x -le $maxX; $x++) {
        $node = $points | Where-Object { $_.x -eq $x -and $_.y -eq $y }
        if ($node) {
            if ($node.kind -eq "machine") {
                $row += "[M]"
            } elseif ($node.kind -eq "identity") {
                $row += "[I]"
            } elseif ($node.kind -eq "repo") {
                $row += "[R]"
            } else {
                $row += "[*]"
            }
        } else {
            $row += " . "
        }
    }
    $grid[$y] = $row
}

foreach ($y in ($grid.Keys | Sort-Object)) {
    Write-Host $grid[$y]
}

Write-Host "`nLegend:" -ForegroundColor Yellow
Write-Host "[M] Machine"
Write-Host "[I] Identity"
Write-Host "[R] Repo"
Write-Host "[*] Other"
Write-Host " .  Empty"
