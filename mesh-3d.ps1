param(
    [string]$MeshFile = "mesh.map.json"
)

if (!(Test-Path $MeshFile)) {
    Write-Host "Mesh file not found: $MeshFile" -ForegroundColor Red
    exit
}

$mesh = Get-Content $MeshFile | ConvertFrom-Json

Write-Host "`n=== 3D MESH VIEW (ISOMETRIC) ===" -ForegroundColor Cyan

function Parse-Coords($c) {
    if (-not $c) { return @(0,0,0) }
    return $c -split "," | ForEach-Object { [int]$_ }
}

function IsoProject($x,$y,$z) {
    $isoX = $x - $y
    $isoY = ($x + $y)/2 - $z
    return @($isoX, $isoY)
}

$points = @()
foreach ($n in $mesh.nodes) {
    $coords = Parse-Coords $n.coordinates
    $p = IsoProject $coords[0] $coords[1] $coords[2]

    $points += [pscustomobject]@{
        id   = $n.id
        kind = $n.kind
        isoX = [math]::Round($p[0])
        isoY = [math]::Round($p[1])
    }
}

if (-not $points) {
    Write-Host "No nodes to render."
    exit
}

$minX = ($points.isoX | Measure-Object -Minimum).Minimum
$maxX = ($points.isoX | Measure-Object -Maximum).Maximum
$minY = ($points.isoY | Measure-Object -Minimum).Minimum
$maxY = ($points.isoY | Measure-Object -Maximum).Maximum

$canvas = @{}
for ($y = $minY; $y -le $maxY; $y++) {
    $row = ""
    for ($x = $minX; $x -le $maxX; $x++) {
        $node = $points | Where-Object { $_.isoX -eq $x -and $_.isoY -eq $y }
        if ($node) {
            $row += switch ($node.kind) {
                "machine"  { "M" }
                "identity" { "I" }
                "repo"     { "R" }
                default    { "*" }
            }
        } else {
            $row += " "
        }
    }
    $canvas[$y] = $row
}

foreach ($y in ($canvas.Keys | Sort-Object)) {
    Write-Host $canvas[$y]
}

Write-Host "`nLegend:" -ForegroundColor Yellow
Write-Host "M = Machine"
Write-Host "I = Identity"
Write-Host "R = Repo"
Write-Host "* = Other"
