param([string]$Node)

$ok = @{
    Node = $Node
    Status = "healthy"
    Time = (Get-Date)
}

return $ok
