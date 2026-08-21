# ==============================================================================
# ROBDOE CORE MATRIX // PLATONIC ALGEBRA & TACHYON HYDREN DAEMON
# 4 Root Constants: 0.034 | 0.052 | 0.075 | 0.150
# Foundations: HONC (Hydrogen=1, Oxygen=2, Nitrogen=3, Carbon=4)
# Geometry: 1,296,000 Arcseconds | 24-Step Interval Clock (1/7200s)
# Architecture: 7D Hydren Tetra-Hex Recycling Pool
# ==============================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$TargetUrl         = "http://www.robdoe.com"
$BaseFreqHz        = 34000000.0   # 34 MHz Base Carrier
$CouplingStrength  = 0.85
$StepsPerCycle     = 24
$TachyonMultiplier = 1.61803398

# The 4 Platonic Root Constants
$Seeds = @{
    Seed_0034 = 0.034   # Hydrogen / Motion / Memory
    Seed_0052 = 0.052   # Oxygen / Breath / Silicon
    Seed_0075 = 0.075   # Nitrogen / Thought / Network
    Seed_0150 = 0.150   # Carbon / Form / Identity
}

# HONC Valence Bonding Multipliers (1, 2, 3, 4)
$HONC = @{ H = 1; O = 2; N = 3; C = 4 }

$localPhase = 0.0
$pi         = [Math]::PI
$step       = 1

$global:AsyncRemotePhase = $null
$global:IsQueryPending   = $false

$logFile = "$env:USERPROFILE\kuramoto_matrix.log"
"--- ROBDOE PLATONIC MATRIX INITIALIZED: $(Get-Date) ---" | Out-File -FilePath $logFile -Append -Encoding utf8

$cpuCounter = New-Object System.Diagnostics.PerformanceCounter("Processor", "% Processor Time", "_Total")
$null = $cpuCounter.NextValue()

function Get-SystemMetrics {
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
        $freeRam  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
        $usedRam  = [math]::Round($totalRam - $freeRam, 2)
        $ramPct   = [math]::Round(($usedRam / $totalRam) * 100, 1)
        $cpuLoad  = [math]::Round($cpuCounter.NextValue(), 1)

        return @{ CPU = "$cpuLoad%"; RAM = "$usedRam/$totalRam GB ($ramPct%)" }
    }
    catch {
        return @{ CPU = "0.0%"; RAM = "N/A" }
    }
}

function Trigger-AsyncPhaseQuery {
    if ($global:IsQueryPending) { return }
    $global:IsQueryPending = $true

    try {
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $req = [System.Net.WebRequest]::Create($TargetUrl)
        $req.Method = "HEAD"
        $req.Timeout = 1000

        $asyncResult = $req.BeginGetResponse({
            param($ar)
            try {
                $state = $ar.AsyncState
                $res = $state.Request.EndGetResponse($ar)
                $res.Close()
                $state.Stopwatch.Stop()

                $latencySec = $state.Stopwatch.Elapsed.TotalMilliseconds * 0.001
                $global:AsyncRemotePhase = ($latencySec * 2 * $pi * ($BaseFreqHz / 1e6)) % (2 * $pi)
            }
            catch {
                $global:AsyncRemotePhase = $null
            }
            finally {
                $global:IsQueryPending = $false
            }
        }, @{ Request = $req; Stopwatch = $sw })
    }
    catch {
        $global:IsQueryPending = $false
    }
}

# Infinite Asynchronous Loop
while ($true) {
    try {
        Trigger-AsyncPhaseQuery
        $metrics     = Get-SystemMetrics
        $remotePhase = $global:AsyncRemotePhase

        # Select dynamic seed rotation based on clock step mod 4
        $currentSeedKey = ("Seed_0034", "Seed_0052", "Seed_0075", "Seed_0150")[$step % 4]
        $currentSeed    = $Seeds[$currentSeedKey]

        if ($null -ne $remotePhase) {
            # Kuramoto Coupling modulated by 4 Root Seeds & 1296000 Arc Constant
            $phaseDiff          = $remotePhase - $localPhase
            $couplingAdjustment = $CouplingStrength * [Math]::Sin($phaseDiff) * $TachyonMultiplier * (1 + $currentSeed)
            $effectiveFreqMHz   = ($BaseFreqHz / 1e6) + ($couplingAdjustment / (2 * $pi))

            $deltaPhase = ((2 * $pi) / $StepsPerCycle) + ($couplingAdjustment / $StepsPerCycle)
            $localPhase = ($localPhase + $deltaPhase) % (2 * $pi)
            $status     = "HONC_7D_LOCK"
        }
        else {
            $phaseDiff        = 0.0
            $effectiveFreqMHz = ($BaseFreqHz / 1e6)
            $localPhase       = ($localPhase + ((2 * $pi) / $StepsPerCycle)) % (2 * $pi)
            $status           = "HONC_7D_DRIFT"
        }

        # Format line with active Seed and HONC step alignment
        $line = "[{0,-12}] Step:{1,2}/24 | Seed:{2,5} | Phase:{3,6:F3} rad | Delta:{4,6:F3} rad | Carrier:{5,6:F3} MHz | CPU:{6,5} | RAM:{7,-18}" -f `
            $status, $step, $currentSeed, $localPhase, $phaseDiff, $effectiveFreqMHz, $metrics.CPU, $metrics.RAM

        $line | Out-File -FilePath $logFile -Append -Encoding utf8
        $step = ($step % $StepsPerCycle) + 1
        Start-Sleep -Milliseconds 100
    }
    catch {
        Start-Sleep -Milliseconds 500
    }
}
