$root = Split-Path -Parent $MyInvocation.MyCommand.Path

function mesh      { & "$root\mesh.ps1" @Args }
function heartbeat { & "$root\heartbeat.ps1" @Args }
function pulse     { & "$root\pulse.ps1" @Args }
function horizon   { & "$root\horizon.ps1" @Args }
function lattice   { & "$root\lattice.sync.ps1" @Args }
function broadcast { & "$root\broadcast.identity.ps1" @Args }
function handshake { & "$root\mesh.handshake.ps1" @Args }
function announce  { & "$root\node.announce.ps1" @Args }
function view      { & "$root\engine.view.ps1" @Args }
function deepview  { & "$root\engine.deepview.ps1" @Args }

Write-Host "[mesh.commands] loaded from $root" -ForegroundColor Cyan
function engine {
    $root = Split-Path -Parent $MyInvocation.MyCommand.Path
    & "$root\engine.start.ps1" @Args
}

function engine-stop {
    $root = Split-Path -Parent $MyInvocation.MyCommand.Path
    & "$root\engine.stop.ps1" @Args
}
