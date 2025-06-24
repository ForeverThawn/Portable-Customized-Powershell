Import-Module $(Resolve-Path -Path "$PSScriptRoot\Compress-Module.psm1")

$Script:Source        = $args[0]
$Script:Destination   = $args[1]
$Script:Method        = $args[2]
$Script:ExtremeSwitch = $args[3]

$Script:WorkingTime = Measure-Command {
    if ($ExtremeSwitch -eq 1) {
        Compress-Archive -Source "$Source" -Destination "$Destination" -Method "$Method" -Extreme
        
    }
    else {
        Compress-Archive -Source "$Source" -Destination "$Destination" -Method "$Method"
    }
}
Write-Host ""
Write-Host "Job Finished! " -ForegroundColor Green -NoNewline
Write-Host "Costs $WorkingTime" -ForegroundColor DarkCyan
PAUSE