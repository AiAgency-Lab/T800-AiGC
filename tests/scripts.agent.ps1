$ErrorActionPreference = "Stop"
$python = "python"
$root   = "C:\(   .   Y    .   )ENGINE"
$script = Join-Path $root "engine_core\engine_agent.py"

& $python $script
