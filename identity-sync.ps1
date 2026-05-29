# --- Identity Sync: Full Sovereign Compute Resolver ---

Write-Host "`n[ Identity Sync ]" -ForegroundColor Cyan

# Load ecosystem
$ecosystem = Get-Content ".\ecosystem.json" -Raw | ConvertFrom-Json

if (-not $ecosystem.systems) {
    Write-Host "No system surfaces defined in ecosystem.json"
    return
}

foreach ($sys in $ecosystem.systems) {

    Write-Host "`n--- Resolving $($sys.name) ---" -ForegroundColor Yellow

    switch ($sys.type) {

        # -------------------------
        # OS
        # -------------------------
        "os" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : OS"
            Write-Host "Coordinates : $($sys.coordinates)"
            Write-Host "Slot        : $($sys.slot)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # CPU
        # -------------------------
        "cpu" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : CPU"
            Write-Host "Cores       : $($sys.cores)"
            Write-Host "Threads     : $($sys.threads)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # GPU
        # -------------------------
        "gpu" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : GPU"
            Write-Host "Memory      : $($sys.memory)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # TPM
        # -------------------------
        "tpm" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : TPM"
            Write-Host "Version     : $($sys.version)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # BIOS
        # -------------------------
        "bios" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : BIOS"
            Write-Host "Version     : $($sys.version)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Network Adapter
        # -------------------------
        "network" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Network Adapter"
            Write-Host "MAC         : $($sys.mac)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # WSL
        # -------------------------
        "wsl" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : WSL"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Linux (Ubuntu)
        # -------------------------
        "linux" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Linux Distro"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Hyper-V
        # -------------------------
        "hyperv" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Hyper-V Host"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Docker Engine
        # -------------------------
        "docker" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Docker Engine"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Toolchain (Git, etc.)
        # -------------------------
        "toolchain" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Toolchain"
            Write-Host "Version     : $($sys.version)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Runtime Plane (Python, Node, PowerShell, Compose, kubectl, gh)
        # -------------------------
        "runtime" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Runtime"
            Write-Host "Version     : $($sys.version)"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Engine Plane (AiFACTORi, AiAgency, Codex, Tesla Coil, Digital Thymus)
        # -------------------------
        "engine" {
            Write-Host "NodeID      : $($sys.id)"
            Write-Host "Type        : Engine"
            Write-Host "Signature   : $($sys.signature)"
        }

        # -------------------------
        # Unknown
        # -------------------------
        default {
            Write-Host "Unknown system type: $($sys.type)"
        }
    }
}


