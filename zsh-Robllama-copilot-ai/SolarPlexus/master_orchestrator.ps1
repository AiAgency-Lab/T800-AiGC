# ====================================================================
# LADBOTONELAD x2 - PURE KURAMOTO 1/0 KINETIC SPINE & MARKOV MERKLE
# ====================================================================

# Pure PS 5.1 / OG .NET Invocation Path Resolution
$BaseDir = if ($MyInvocation.MyCommand.Path) { Split-Path -Parent $MyInvocation.MyCommand.Path } else { Get-Location }

$LogsDir = Join-Path $BaseDir "logs"
$MerkleDir = Join-Path $BaseDir "merkle"
$RootHashFile = Join-Path $MerkleDir "root_hex728.hash"

$null = New-Item -ItemType Directory -Force -Path $LogsDir
$null = New-Item -ItemType Directory -Force -Path $MerkleDir

$Chakras = @(
    @{ Folder = "Crown"; Model = "llama3.1:latest"; BasePhase = 0.0 },
    @{ Folder = "ThirdEye"; Model = "llama3:latest"; BasePhase = 0.9 },
    @{ Folder = "Throat"; Model = "phi3:latest"; BasePhase = 1.8 },
    @{ Folder = "Heart"; Model = "llama3.2:1b"; BasePhase = 2.7 },
    @{ Folder = "SolarPlexus"; Model = "qwen2.5-coder:7b"; BasePhase = 3.6 },
    @{ Folder = "Sacral"; Model = "llama3:8b"; BasePhase = 4.5 },
    @{ Folder = "Root"; Model = "phi3:latest"; BasePhase = 5.4 }
)

function Write-KineticLog {
    param ([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry = "[$Timestamp] [PURE-KINETIC-SPINE] $Message"
    Add-Content -Path (Join-Path $LogsDir "lattice_daemon.log") -Value $Entry
}

function Update-MarkovMerkleRoot {
    param ([string]$StateString)
    try {
        # Pure .NET Framework Cryptography Engine Integration
        $Bytes = [System.Text.Encoding]::UTF8.GetBytes($StateString)
        $HashAlgorithm = [System.Security.Cryptography.SHA256]::Create()
        $HashBytes = $HashAlgorithm.ComputeHash($Bytes)
        
        # Free memory footprint explicitly for .NET CLR
        $HashAlgorithm.Dispose()
        
        $HexHash = [BitConverter]::ToString($HashBytes) -replace '-'
        Set-Content -Path $RootHashFile -Value $HexHash
        return $HexHash
    } catch {
        return "ERROR_HASH_GEN"
    }
}

function Invoke-PureKuramotoKineticStep {
    param ([double]$TimeSeconds)
    $N = $Chakras.Count
    $Phases = @()
    $KineticStates = @()

    foreach ($Chakra in $Chakras) {
        $omega = 2.0 * [Math]::PI / 12.0
        $theta = $Chakra.BasePhase + ($omega * $TimeSeconds)
        $Phases += $theta

        $BinaryState = if ([Math]::Sin($theta) -ge 0) { "1" } else { "0" }
        $KineticStates += "$($Chakra.Folder):$BinaryState"
    }

    $SumCos = 0.0
    $SumSin = 0.0
    foreach ($p in $Phases) {
        $SumCos += [Math]::Cos($p)
        $SumSin += [Math]::Sin($p)
    }
    
    # Patched Order Parameter math
    $r = [Math]::Round((($SumCos * $SumCos) + ($SumSin * $SumSin)) / $N, 4)

    $StatePayload = $KineticStates -join "|"
    $MerkleRoot = Update-MarkovMerkleRoot -StateString "$StatePayload|r:$r|t:$TimeSeconds"

    return [PSCustomObject]@{
        OrderParameter = $r
        Payload = $StatePayload
        MerkleRoot = $MerkleRoot
    }
}

Write-KineticLog "Pure Kuramoto 1/0 Kinetic Spine & Markov Merkle Engine INITIALIZED."

while ($true) {
    try {
        # OG .NET DateTime Epoch calculation
        $UnixEpoch = New-Object DateTime(1970, 1, 1, 0, 0, 0, [System.DateTimeKind]::Utc)
        $TickEpoch = [Math]::Floor(((Get-Date).ToUniversalTime() - $UnixEpoch).TotalSeconds)
        $HarmonicPhase = $TickEpoch % 12

        $KineticResult = Invoke-PureKuramotoKineticStep -TimeSeconds $TickEpoch
        Write-KineticLog "T-Mod 12 = [$HarmonicPhase]s | Kuramoto r = [$($KineticResult.OrderParameter)] | 1/0 State: [$($KineticResult.Payload)] | Merkle Root: $($KineticResult.MerkleRoot.Substring(0,16))..."

        Start-Sleep -Seconds 12
    } catch {
        Write-KineticLog "Kinetic loop exception: $_"
        Start-Sleep -Seconds 5
    }
}
