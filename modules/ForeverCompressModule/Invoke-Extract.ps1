Import-Module $(Resolve-Path -Path "$PSScriptRoot\Decompress-Module.psm1")

$Script:Source        = $args[0]
$Script:Destination   = $args[1]

$Script:WorkingTime = Measure-Command {
    Format-Archive -Source "$Source" -Destination "$Destination"
}
Write-Host ""
Write-Host "Job Finished! " -ForegroundColor Green -NoNewline
Write-Host "Costs $WorkingTime" -ForegroundColor DarkCyan
PAUSE