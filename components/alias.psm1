Function Global:Call-Explorer {
param(
    [string] $Path = '.'
)
    if ($Path -eq '.') {
        $pipeway = Get-Location
        Write-Host -ForegroundColor DarkCyan -Object ('Enter location at Current Location "') -NoNewline
        Write-Host -ForegroundColor DarkMagenta -Object ($pipeway) -NoNewline
        Write-Host -ForegroundColor DarkCyan -Object ('"')
        Start-Process explorer.exe -ArgumentList ($pipeway)
    } else {
        $pipeway = '"' + $Path + '"'
        Write-Host -ForegroundColor DarkCyan -Object ('Enter location at "') -NoNewline
        Write-Host -ForegroundColor DarkYellow -Object ($Path) -NoNewline
        Write-Host -ForegroundColor DarkCyan -Object ('"')
        Start-Process explorer.exe -ArgumentList ($pipeway)
    }
}

Function Global:RecycleBin {
    start shell:RecycleBinFolder
}

Function Global:Convert-ToHex {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Value
    )
    $dec = [System.Convert]::ToInt64($Value)
    $hex = '{0:X}' -f $dec
    return $hex
}

Function Global:Convert-ToKB {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Value
    )
    $ret = [System.Convert]::ToUInt64($Value) / 1KB
    return $ret
}

Function Global:Convert-ToMB {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Value
    )
    $ret = [System.Convert]::ToUInt64($Value) / 1MB
    return $ret
}

Function Global:Convert-ToGB {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Value
    )
    $ret = [System.Convert]::ToUInt64($Value) / 1GB
    return $ret
}

Function Global:Convert-ToTB {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Value
    )
    $ret = [System.Convert]::ToUInt64($Value) / 1TB
    return $ret
}

Function Global:Convert-ToPB {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Value
    )
    $ret = [System.Convert]::ToUInt64($Value) / 1PB
    return $ret
}


#Set-Alias -Name "move" -Value "fmove" -Option AllScope -Scope Global
Set-Alias -Name "reset" -Value "At-Startup.ps1" -Option AllScope -Scope Global
Set-Alias -Name "reload" -Value "Reload-ForeverPowershell" -Option AllScope -Scope Global
Set-Alias -Name "su" -Value "Supervise-Powershell" -Option AllScope -Scope Global
Set-Alias -Name "sudo" -Value "gsudo" -Option AllScope -Scope Global
Set-Alias -Name "to-Hex" -Value "Convert-ToHex" -Option AllScope -Scope Global
Set-Alias -Name "to-KB" -Value "_Convert-to-KB.ps1" -Option AllScope -Scope Global
Set-Alias -Name "to-MB" -Value "_Convert-to-MB.ps1" -Option AllScope -Scope Global
Set-Alias -Name "to-GB" -Value "_Convert-to-GB.ps1" -Option AllScope -Scope Global
Set-Alias -Name "to-TB" -Value "_Convert-to-TB.ps1" -Option AllScope -Scope Global
Set-Alias -Name "to-PB" -Value "_Convert-to-PB.ps1" -Option AllScope -Scope Global
Set-Alias -Name "e" -Value "Call-Explorer" -Option AllScope -Scope Global
Set-Alias -Name "anaconda" -Value "Start-Anaconda" -Option AllScope -Scope Global
Set-Alias -Name "fvi" -Value "forever-virtual-inputter" -Option AllScope -Scope Global
Set-Alias -Name "performance" -Value "Show-Performance" -Option AllScope -Scope Global
Set-Alias -Name "timestamp" -Value "Convert-Timestamp" -Option AllScope -Scope Global
Set-Alias -Name "z" -Value "Compress-ArchiveWithTimeStamp" -Option AllScope -Scope Global
Set-Alias -Name "touch" -Value "New-Item" -Option AllScope -Scope Global
Set-Alias -Name "search" -Value "Call-Everything" -Option AllScope -Scope Global
Set-Alias -Name "trashbin" -Value "RecycleBin" -Option AllScope -Scope Global


Set-Alias -Name "n" -Value "New-Shell" -Option AllScope -Scope Global