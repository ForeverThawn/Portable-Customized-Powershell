Function Format-Size {
param (
    [Parameter(Mandatory=$true)]
    [double]$ByteSize,

    [Parameter(Mandatory=$false)]
    [ValidateSet("B", "KB", "MB", "GB", "TB", "PB")]
    [string]$Unit = "auto"
)

    switch ($Unit) {
        "B" {
            return ('{0:n2} B' -f $ByteSize)
        }
        "KB" {
            return ('{0:n2} KB' -f ($ByteSize / 1KB))
        }
        "MB" {
            return ('{0:n2} MB' -f ($ByteSize / 1MB))
        }
        "GB" {
            return ('{0:n2} GB' -f ($ByteSize / 1GB))
        }
        "TB" {
            return ('{0:n2} TB' -f ($ByteSize / 1TB))
        }
        "PB" {
            return ('{0:n2} PB' -f ($ByteSize / 1PB))
        }
        "auto" {
            if ($ByteSize -lt 1KB) {
                return ('{0:n2} B' -f $ByteSize)
            }
            elseif ($ByteSize -lt 1MB) {
                return ('{0:n2} KB' -f ($ByteSize / 1KB))
            }
            elseif ($ByteSize -lt 1GB) {
                return ('{0:n2} MB' -f ($ByteSize / 1MB))
            }
            elseif ($ByteSize -lt 1TB) {
                return ('{0:n2} GB' -f ($ByteSize / 1GB))
            }
            elseif ($ByteSize -lt 1PB) {
                return ('{0:n2} TB' -f ($ByteSize / 1TB))
            }
            else {
                return ('{0:n2} PB' -f ($ByteSize / 1PB))
            }
        }
    }
}

Function Get-DirectorySize {
param (
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [Parameter(Mandatory=$false)]
    [ValidateSet("B", "KB", "MB", "GB", "TB", "PB")]
    [string]$Unit = "auto"
)
    if (-Not (Test-Path $Path)) {
        Write-Error "Path Not Found: $Path"
        return
    }

    $item = Get-Item $Path

    $size = 0

    # 文件夹目标
    if ($item -is [System.IO.DirectoryInfo]) {
        $size = (Get-ChildItem $Path -Recurse | Measure-Object -Property Length -Sum).Sum
    } else {
        # 文件目标
        $size = $item.Length
    }

    if ($Unit -eq "auto") {
        $SpecifiedUnitSize = '   '
        $SpecifiedUnitSize += Format-Size -ByteSize $size
    } else {
        $SpecifiedUnitSize = '   '
        $SpecifiedUnitSize += Format-Size -ByteSize $size -Unit $Unit
    }

    $property =  [ordered]@{
        Attributes = $item.Attributes.ToString()
        'Name     ' = $item.Name
        'Total Size' = $SpecifiedUnitSize
        #LastModified = $item.LastWriteTime
    }

    $result = New-Object PSObject -Property $property
    return $result
}

Function Get-ChildItemDetails {
    param(
    [string] $dir_path
    )
    
    if ($dir_path -eq "") {
        $dir_path = Get-Location
    }
        
    Write-Host ""
    Write-Host ("Directory  ") -NoNewline
    Write-Host $dir_path -NoNewline -ForegroundColor DarkYellow
    Write-Host (" >>")
    
    $global:sum_length = 0
    
    Get-ChildItem $dir_path |
    Format-Table -Wrap -AutoSize -Property Mode, LastWriteTime,
       @{ Label = "        Size"; alignment = "Right";
            Expression = {
                        if($_.PSIsContainer -eq $True) {
                            $dir_byte_size = (New-Object -com  Scripting.FileSystemObject).GetFolder( $_.FullName).Size
                            $global:sum_length += $dir_byte_size
                            Format-Size($dir_byte_size)
                        }  
                        else {
                            $file_size = $_.Length
                            $global:sum_length += $file_size
                            Format-Size($file_size)
                        }
            }
        }, Name;
        
    $global:sum_length = Format-Size($global:sum_length)
    Write-Host "File(s) in total :   " -NoNewline 
    Write-Host $global:sum_length -ForegroundColor DarkYellow
    $global:sum_length = 0
}


Export-ModuleMember -Function Format-Size
Export-ModuleMember -Function Get-DirectorySize
Export-ModuleMember -Function Get-ChildItemDetails

Set-Alias -Name "dirs" -Value "Get-ChildItemDetails" -Option AllScope -Scope global
Set-Alias -Name "Get-Size" -Value "Get-ChildItemDetails" -Option AllScope -Scope global
