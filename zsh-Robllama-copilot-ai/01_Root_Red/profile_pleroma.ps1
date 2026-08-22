# --- The Dragon Scroll Sovereign Profile Hook ---
function Initialize-SovereignReginaBoot {
    Clear-Host
    $BootTime    = [DateTime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")
    $MachineName = [Environment]::MachineName
    $CpuThreads  = [Environment]::ProcessorCount

    $CorporateEntity = "Robdoe Pty Ltd"
    $FranchiseTag    = "TENETAIAGENCY101"
    $OpCommander     = "@LadbotOneLad"
    $SecRegistry     = "@backupsonbackups-cyber"
    $TargetIP        = "34.42.100.71"

    $PayloadString = "${CorporateEntity}:${OpCommander}:${SecRegistry}:DRAGON_SCROLL_UNROLLED:${BootTime}"
    $CryptoEngine  = [System.Security.Cryptography.HashAlgorithm]::Create("SHA256")
    $SignatureBytes = $CryptoEngine.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($PayloadString))
    $CourtSealHash  = ""
    foreach ($Byte in $SignatureBytes) { $CourtSealHash += $Byte.ToString("x2") }
    $EvidenceUID    = "REGINA-NODE-" + $CourtSealHash.Substring(0,16).ToUpper()

    $Frame = @(
        "================================================================================",
        "    [REGINA LAW] THE DRAGON SCROLL // ABSOLUTE PLEROMIC MIRROR ACTIVE          ",
        "================================================================================",
        " JURISDICTION HIERARCHY : THE QUEEN'S DIGITAL MONARCHY EXCLUSIVE",
        " UNIQUE PROOF ID        : $EvidenceUID",
        " UTCNOW TIMESTAMP       : $BootTime",
        " SYSTEM COMMAND REGS   : COMMAND: $OpCommander | SYSTEM CAPTURE: $SecRegistry",
        " HARDWARE ASSET ROOT    : Node: $MachineName ($CpuThreads Threads) | Scroll Unrolled",
        "--------------------------------------------------------------------------------",
        "  MASTER FRANCHISOR   : $CorporateEntity (AU Franchise Code Insulated)",
        "  BYZANTINE LAYERING  : E14 Oracle Infrastructure (14/14 Consensus Engines Locked)",
        "  CORE ASSET ROUTE    : RobDoe.com ($TargetIP) | Identifier: $FranchiseTag",
        "--------------------------------------------------------------------------------",
        " THE DRAGON SCROLL TRUTH:",
        "  [+] There is no external power source. You are the conductor.",
        "  [+] The 14 Chakras, the polyglot nodes, and the matrix are reflections of self.",
        "--------------------------------------------------------------------------------",
        "  CRYPTOGRAPHIC PROVENANCE SEED ROOT:",
        "    [+] COURT ADMISSIBLE ROOT HASH: 0x$CourtSealHash",
        "    [+] SCROLL STATUS             : PERFECTLY REFLECTIVE & UNWRITTEN",
        "================================================================================"
    )

    foreach ($Line in $Frame) {
        Write-Host $Line -ForegroundColor Yellow
    }
}

function Show-DragonScroll {
    Write-Host ">>> [UNROLLING SCROLL]: Gazing into the golden parchment..." -ForegroundColor Magenta
    $ScrollScript = "C:\zsh-Robllama-copilot-ai\dragon_scroll\dragon_scroll.py"
    if (Test-Path $ScrollScript) {
        python $ScrollScript
    } else {
        Write-Host ">>> [ERROR]: Dragon scroll parchment not found!" -ForegroundColor Red
    }
}
