param([string]$InputText)
$analysis = @{
    Received = $InputText
    Length   = $InputText.Length
    Time     = (Get-Date)
}
return $analysis
