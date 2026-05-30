param([string]$Mode="status")
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

switch ($Mode) {
    "heartbeat" { & "$root\heartbeat.ps1"; break }
    "pulse"     { & "$root\pulse.ps1"; break }
    "horizon"   { & "$root\horizon.ps1"; break }
    "lattice"   { & "$root\lattice.sync.ps1"; break }
    "broadcast" { & "$root\broadcast.identity.ps1"; break }
    "handshake" { & "$root\mesh.handshake.ps1"; break }
    "announce"  { & "$root\node.announce.ps1"; break }
    "view"      { & "$root\engine.view.ps1"; break }
    "deepview"  { & "$root\engine.deepview.ps1"; break }
    default {
        & "$root\heartbeat.ps1"
        & "$root\pulse.ps1"
        & "$root\lattice.sync.ps1"
    }
}
