Import-Module $(Resolve-Path -Path "$PSScriptRoot\Compress-Module.psm1")

$Script:Source              = $args[0]
$Script:Method              = $args[1]
$Script:ExtremeSwitch       = $args[2]

$Script:WorkingTime = Measure-Command {
    if ($ExtremeSwitch -eq 1) {
        Compress-ArchiveWithTimeStamp -Source "$Source" -Method "$Method" -WithTimeStamp -Extreme
        
    }
    else {
        Compress-ArchiveWithTimeStamp -Source "$Source" -Method "$Method" -WithTimeStamp
    }
}
Write-Host ""
Write-Host "Job Finished! " -ForegroundColor Green -NoNewline
Write-Host "Costs $WorkingTime" -ForegroundColor DarkCyan
PAUSE