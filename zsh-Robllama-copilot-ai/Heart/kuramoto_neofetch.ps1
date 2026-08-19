# ==============================================================================
# ROBDOE CORE MATRIX // KURAMOTO SWARM NODE (PS 5.1 COMPATIBLE)
# Clock Base: 24-Step Interval Train (1/7200s sample tick resolution)
# Target: http://www.robdoe.com
# ==============================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$TargetUrl = "http://www.robdoe.com"
$NaturalFreq = 50.0
$CouplingStrength = 0.85
$StepsPerCycle = 24
$localPhase = 0.0
$pi = [Math]::PI
$step = 1

# Setup log file path
$logFile = "$env:USERPROFILE\kuramoto_matrix.log"
"--- ROBDOE KURAMOTO MATRIX LOG INIT: $(Get-Date) ---" | Out-File -FilePath $logFile -Encoding utf8

# Task Manager CPU Counter Initialization
$cpuCounter = New-Object System.Diagnostics.PerformanceCounter("Processor", "% Processor Time", "_Total")
$null = $cpuCounter.NextValue()

function Get-SystemMetrics {
    $os = Get-CimInstance Win32_OperatingSystem
    $totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $freeRam = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $usedRam = [math]::Round($totalRam - $freeRam, 2)
    $ramPct  = [math]::Round(($usedRam / $totalRam) * 100, 1)
    $cpuLoad = [math]::Round($cpuCounter.NextValue(), 1)

    return @{
        Host   = $env:COMPUTERNAME
        CPU    = "$cpuLoad%"
        RAM    = "$usedRam/$totalRam GB ($ramPct%)"
        Uptime = "$((Get-Date) - $os.LastBootUpTime | Select-Object -ExpandProperty Days)d"
    }
}

function Get-RemotePhase {
    param ([string]$Url)
    try {
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $req = [System.Net.WebRequest]::Create($Url)
        $req.Method = "HEAD"
        $req.Timeout = 1200
        $res = $req.GetResponse()
        $res.Close()
        $sw.Stop()

        return ($sw.Elapsed.TotalMilliseconds * 0.001 * 2 * $pi * $NaturalFreq) % (2 * $pi)
    }
    catch {
        return $null
    }
}

# Clear screen once at initialization
Clear-Host
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "            ROBDOE PTY LTD // KURAMOTO MATRIX SYNCHRONIZER             " -ForegroundColor Primary
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "Target Endpoint : $TargetUrl"
Write-Host "Logging To      : $logFile"
Write-Host "----------------------------------------------------------------------" -ForegroundColor DarkGray

try {
    while ($true) {
        $metrics = Get-SystemMetrics
        $remotePhase = Get-RemotePhase -Url $TargetUrl

        if ($null -ne $remotePhase) {
            # Kuramoto Coupling Equation
            $phaseDiff = $remotePhase - $localPhase
            $couplingAdjustment = $CouplingStrength * [Math]::Sin($phaseDiff)
            $effectiveFreq = $NaturalFreq + $couplingAdjustment

            # Phase Step Forward
            $deltaPhase = ((2 * $pi) / $StepsPerCycle) + ($couplingAdjustment / $StepsPerCycle)
            $localPhase = ($localPhase + $deltaPhase) % (2 * $pi)
            $status = "LOCKED "
            $fgColor = "Green"
        }
        else {
            # Drift Execution
            $phaseDiff = 0.0
            $effectiveFreq = $NaturalFreq
            $localPhase = ($localPhase + ((2 * $pi) / $StepsPerCycle)) % (2 * $pi)
            $status = "DRIFT  "
            $fgColor = "Yellow"
        }

        # Perfectly aligned line-by-line terminal output
        $line = "[{0}] Step:{1,2}/24 | Phase:{2,6:F3} rad | Delta:{3,6:F3} rad | Freq:{4,5:F1}Hz | CPU:{5,5} | RAM:{6,-18}" -f `
            $status, $step, $localPhase, $phaseDiff, $effectiveFreq, $metrics.CPU, $metrics.RAM

        Write-Host $line -ForegroundColor $fgColor

        # Save state to log file
        $line | Out-File -FilePath $logFile -Append -Encoding utf8

        $step = ($step % $StepsPerCycle) + 1
        Start-Sleep -Milliseconds 250
    }
}
finally {
    Write-Host "`n[*] Terminated." -ForegroundColor Red
}