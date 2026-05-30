$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$python = "python"
$agent = Join-Path $root "..\engine_core\engine_agent.py"
& $python $agent
