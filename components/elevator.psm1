# $gsudo = Resolve-Path -Path "$PSScriptRoot\..\bin\gsudo\gsudo.exe" -ErrorAction Stop

# Function Global:Invoke-Sudo {
# param(
#     [Parameter(Mandatory = $true)]
#     $Arguments
# )
#     Start-Process $gsudo -ArgumentList "$Arguments" -NoNewWindow -Wait
# }

Set-Alias -Name 'sudo' -Value "$PSScriptRoot\..\bin\gsudo\gsudo.exe" -Option AllScope -Scope Global

Function Global:Call-TrustedInstaller {
    $startupCommand = "pwsh.exe -Nologo -NoExit -File `"$($PSScriptRoot)\..\profile.ps1`" reload"
    sudo --ti $startupCommand
}

Function Global:Call-System {
    $startupCommand = "pwsh.exe -Nologo -NoExit -File `"$($PSScriptRoot)\..\profile.ps1`" reload"
    sudo -s $startupCommand
}
