param(
    [string]$Intent = "status",
    [string]$Context = ""
)

$ErrorActionPreference = "Stop"

$python = "python"

$script = @"
from engine_core.lucy.lucy_interface import ask_lucy
import sys

intent = sys.argv[1] if len(sys.argv) > 1 else "status"
context = sys.argv[2] if len(sys.argv) > 2 else ""
print(ask_lucy(intent, context))
"@

$tmp = [System.IO.Path]::GetTempFileName() + ".py"
[System.IO.File]::WriteAllText($tmp, $script)

try {
    & $python $tmp $Intent $Context
}
finally {
    Remove-Item $tmp -ErrorAction SilentlyContinue
}
