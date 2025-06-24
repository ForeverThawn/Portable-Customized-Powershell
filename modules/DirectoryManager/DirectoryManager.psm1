$Global:DirectoryManager = New-Object System.Collections.Generic.List[Object]
$Script:configPath = "$PSScriptRoot\config.cfg"

class LocationItem {
    [int]$Index
    [string]$Location

    LocationItem([int]$index, [string]$location) {
        $this.Index = $index
        $this.Location = $location
    }
}

Function Script:Initialize-DirectoryManager {
    $Global:0 = if ($DirectoryManager.Count -gt 0) { $DirectoryManager[0] } else { $null }
    $Global:1 = if ($DirectoryManager.Count -gt 1) { $DirectoryManager[1] } else { $null }
    $Global:2 = if ($DirectoryManager.Count -gt 2) { $DirectoryManager[2] } else { $null }
    $Global:3 = if ($DirectoryManager.Count -gt 3) { $DirectoryManager[3] } else { $null }
    $Global:4 = if ($DirectoryManager.Count -gt 4) { $DirectoryManager[4] } else { $null }
    $Global:5 = if ($DirectoryManager.Count -gt 5) { $DirectoryManager[5] } else { $null }
    $Global:6 = if ($DirectoryManager.Count -gt 6) { $DirectoryManager[6] } else { $null }
    $Global:7 = if ($DirectoryManager.Count -gt 7) { $DirectoryManager[7] } else { $null }
    $Global:8 = if ($DirectoryManager.Count -gt 8) { $DirectoryManager[8] } else { $null }
    $Global:9 = if ($DirectoryManager.Count -gt 9) { $DirectoryManager[9] } else { $null }
}

Function Global:Add-DirectoryManager {
    param(
        [Parameter(Mandatory=$false)]
        [string]$Path
    )

    if (-not $Path) {
        $Path = Get-Location
        $Global:DirectoryManager.Add($Path)
        Write-Host 'Added "' -ForegroundColor DarkCyan -NoNewline
        Write-Host "$Path" -ForegroundColor Green -NoNewline
        Write-Host '" to the directory list.' -ForegroundColor DarkCyan
        Initialize-DirectoryManager
        Update-DirectoryManager
        Return
    }

    if (Test-Path $Path) {
        $Path = Resolve-Path $Path
        $Global:DirectoryManager.Add($Path)
        Write-Host 'Added "' -ForegroundColor DarkCyan -NoNewline
        Write-Host "$Path" -ForegroundColor Green -NoNewline
        Write-Host '" to the directory list.' -ForegroundColor DarkCyan
        Initialize-DirectoryManager
        Update-DirectoryManager
        Return
    }
    
    if ($Path.StartsWith('http')) {
        $Global:DirectoryManager.Add($Path)
        Write-Host 'Added "' -ForegroundColor DarkCyan -NoNewline
        Write-Host "$Path" -ForegroundColor Green -NoNewline
        Write-Host '" to the directory list. ' -ForegroundColor DarkCyan -NoNewline
        Write-Host '[URL]' -ForegroundColor White
        Initialize-DirectoryManager
        Update-DirectoryManager
        Return
    }
}

Function Global:Remove-DirectoryManager {
    param(
        [Parameter(Mandatory=$false)]
        [int]$Index = -1,
        [Parameter(Mandatory=$false)]
        [Switch]$All
    )

    if ($All -eq $True) {
        $Global:DirectoryManager = New-Object System.Collections.Generic.List[Object]
        Write-Host 'Directory list cleared.' -ForegroundColor DarkRed
        Initialize-DirectoryManager
        Update-DirectoryManager
        return
    }
    if ($Index -eq -1) {
        Write-Host "Enter the index of the directory to remove: " -ForegroundColor DarkYellow
        Write-Host "    dd <Index>" 
        Write-Host "Or clean the list:" -ForegroundColor DarkYellow
        Write-Host "    dd -All"
        Initialize-DirectoryManager
        Update-DirectoryManager
        return
    }
    if ($Index -lt $DirectoryManager.Count -and $Index -ge 0) {
        Write-Host 'Removed "' -ForegroundColor DarkCyan -NoNewline
        Write-Host ($Global:DirectoryManager[$Index]) -ForegroundColor Red -NoNewline
        Write-Host '" from the directory list.' -ForegroundColor DarkCyan
        $Global:DirectoryManager.RemoveAt($Index)
        Initialize-DirectoryManager
        Update-DirectoryManager
    }
    else {
        throw "Index '$Index' does not exist."
    }

}

Function Global:Get-DirectoryManager {
    Update-DirectoryManager
    if ($Global:DirectoryManager.Count -eq 0) {
        Write-Host 'Directory Manager List Empty' -ForegroundColor Red
        return
    }
    $ret = @()
    $index = 0
    Foreach ($location in $Global:DirectoryManager) {
        $item = [LocationItem]::new($index, $location)
        $ret += $item
        $index++
    }

    Initialize-DirectoryManager 
    Update-DirectoryManager
    Return $ret
}

# Function Global:Set-DirectoryDeprecated {
#     param(
#         [Parameter(Mandatory=$true)]
#         [string]$Index
#     )

#     if ($Index -lt $DirectoryManager.Count -and $Index -ge 0) {
#         Set-Location $DirectoryManager[$Index]
#     }
#     else {
#         throw "Index '$Index' is out of range."
#     }
# }

Function Global:Show-DirectoryManagerHelp {
    Write-Host "Directory Manager Help" -ForegroundColor Green
    Write-Host "========================" -ForegroundColor Green
    class HelpColumn {
        [string]$Command
        [string]$Description
    
        HelpColumn([string]$Command, [string]$Description) {
            $this.Command = $Command
            $this.Description = $Description
        }
    }

    $help = @()
    $help += [HelpColumn]::new("dl", "List all directories in the directory manager list.")
    $help += [HelpColumn]::new("da", "Add a directory to the directory manager list.")
    $help += [HelpColumn]::new("dd <index>", "Delete a directory from the directory manager list.")
    $help += [HelpColumn]::new("dd", "Clear the directory manager list.")
    $help += [HelpColumn]::new("d", "Show this help list.")
    $help += [HelpColumn]::new("$<list_index>", "Return the specified path from the list")
    Return $help
}

Function Global:Update-DirectoryManager {
param ()
    if (Test-Path -Path $Script:configPath) {
        $Script:savedConfig = Get-Content -Path $Script:configPath
    } else {
        Set-Content -Path $Script:configPath -Value $Global:DirectoryManager
        Return
    }

    if (0 -eq $Global:DirectoryManager.Count) {
        $Global:DirectoryManager = New-Object System.Collections.Generic.List[Object]
        foreach ($path in $Script:savedConfig) {
            $Global:DirectoryManager.Add($path)
        }
    } else {
        Set-Content -Path $Script:configPath -Value $Global:DirectoryManager
    }
    
}

Set-Alias -Name "da" -Value "Add-DirectoryManager" -Option AllScope -Scope Global
Set-Alias -Name "dl" -Value "Get-DirectoryManager" -Option AllScope -Scope Global
Set-Alias -Name "dd" -Value "Remove-DirectoryManager" -Option AllScope -Scope Global
Set-Alias -Name "d" -Value "Show-DirectoryManagerHelp" -Option AllScope -Scope Global
