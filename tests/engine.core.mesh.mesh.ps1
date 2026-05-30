param(
    [ValidateSet("status","heartbeat","pulse","horizon","lattice","broadcast","handshake","announce","view","deepview")]
    [string]$Mode = "status"
)

$ErrorActionPreference = "SilentlyContinue"

$Self       = Split-Path -Parent $MyInvocation.MyCommand.Path
$MeshRoot   = $Self
$EngineRoot = Split-Path -Parent $MeshRoot

. "$MeshRoot\heartbeat.ps1"
. "$MeshRoot\pulse.ps1"
. "$MeshRoot\horizon.ps1"
. "$MeshRoot\lattice.sync.ps1"
. "$MeshRoot\broadcast.identity.ps1"
. "$MeshRoot\mesh.handshake.ps1"
. "$MeshRoot\node.announce.ps1"
. "$MeshRoot\engine.view.ps1"
. "$MeshRoot\engine.deepview.ps1"

switch ($Mode) {
    "heartbeat" { Invoke-MeshHeartbeat; break }
    "pulse"     { Invoke-MeshPulse; break }
    "horizon"   { Invoke-MeshHorizon; break }
    "lattice"   { Invoke-MeshLattice; break }
    "broadcast" { Invoke-MeshBroadcastIdentity; break }
    "handshake" { Invoke-MeshHandshake; break }
    "announce"  { Invoke-MeshNodeAnnounce; break }
    "view"      { Invoke-EngineView; break }
    "deepview"  { Invoke-EngineDeepView; break }
    "status"    {
        Invoke-MeshHeartbeat
        Invoke-MeshPulse
        Invoke-MeshLattice
        break
    }
}
