$invokeExtractPs1 = Resolve-Path -Path ".\Invoke-Extract.ps1"
$invokeCompressPs1 = Resolve-Path -Path ".\Invoke-Compress.ps1"
$invokeCompressWithTimestampPs1 = Resolve-Path -Path ".\Invoke-CompressWithTimestamp.ps1"

$basePaths = @(
    "HKCR:\*\shell\ForeverCompressModule",
    "HKCR:\Folder\shell\ForeverCompressModule"
)

foreach ($basePath in $basePaths) {
    # 主项
    $mainKey = New-Item -Path $basePath -Force
    Set-ItemProperty -Path $mainKey.PSPath -Name "MUIVerb" -Value "Forever Compress Module"
    Set-ItemProperty -Path $mainKey.PSPath -Name "SubCommands" -Value ""

    # shell子项
    $shellKey = New-Item -Path "$basePath\shell" -Force
    Set-ItemProperty -Path $shellKey.PSPath -Name "(Default)" -Value ""

    # Extract Here
    $extractKey = New-Item -Path "$basePath\shell\CompressExtract" -Force
    Set-ItemProperty -Path $extractKey.PSPath -Name "MUIVerb" -Value "Extract Here"
    $extractCmdKey = New-Item -Path "$extractKey\command" -Force
    Set-ItemProperty -Path $extractCmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeExtractPs1`" `"%1`""

    # To .zip
    $zExtremeKey = New-Item -Path "$basePath\shell\CompressZExtreme" -Force
    Set-ItemProperty -Path $zExtremeKey.PSPath -Name "MUIVerb" -Value "To .zip"
    $zExtremeCmdKey = New-Item -Path "$zExtremeKey\command" -Force
    Set-ItemProperty -Path $zExtremeCmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressPs1`" `"%1`" `"%1.zip`" `"zip`" 0"

    # CompressZHigh（仅设置CommandFlags）
    $zHighKey = New-Item -Path "$basePath\shell\CompressZHigh" -Force
    Set-ItemProperty -Path $zHighKey.PSPath -Name "CommandFlags" -Type DWord -Value 0x00000008

    # To .z [Extreme] profile
    if ($basePath -match '\*\\shell') {
        $zipKey = New-Item -Path "$basePath\shell\CompressZip" -Force
        Set-ItemProperty -Path $zipKey.PSPath -Name "MUIVerb" -Value "To .z [Extreme] profile"
        $zipCmdKey = New-Item -Path "$zipKey\command" -Force
        Set-ItemProperty -Path $zipCmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressPs1`" `"%1`" `"%1.z`" `"zstd`" 1"
    }
    # To .z [High] profile
    else {
        $zipKey = New-Item -Path "$basePath\shell\CompressZip" -Force
        Set-ItemProperty -Path $zipKey.PSPath -Name "MUIVerb" -Value "To .z [High] profile"
        $zipCmdKey = New-Item -Path "$zipKey\command" -Force
        Set-ItemProperty -Path $zipCmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressPs1`" `"%1`" `"%1.z`" `"zstd`" 0"
    }

    # To .z [High] profile（文件类型）/To .z [Extreme] profile（文件夹类型）
    $zTimestampKey = New-Item -Path "$basePath\shell\CompressZTimestamp" -Force
    if ($basePath -match '\*\\shell') {
        Set-ItemProperty -Path $zTimestampKey.PSPath -Name "MUIVerb" -Value "To .z [High] profile"
        $zTimestampCmdKey = New-Item -Path "$zTimestampKey\command" -Force
        Set-ItemProperty -Path $zTimestampCmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressPs1`" `"%1`" `"%1.z`" `"zstd`" 0"
    }
    else {
        Set-ItemProperty -Path $zTimestampKey.PSPath -Name "MUIVerb" -Value "To .z [Extreme] profile"
        $zTimestampCmdKey = New-Item -Path "$zTimestampKey\command" -Force
        Set-ItemProperty -Path $zTimestampCmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressPs1`" `"%1`" `"%1.z`" `"zstd`" 1"
    }

    # CompressZTimestampExtreme（仅设置CommandFlags）
    $zTimestampExtremeKey = New-Item -Path "$basePath\shell\CompressZTimestampExtreme" -Force
    Set-ItemProperty -Path $zTimestampExtremeKey.PSPath -Name "CommandFlags" -Type DWord -Value 0x00000008

    # To .z with timestamp
    $zTimestamp0Key = New-Item -Path "$basePath\shell\CompressZTimestampExtreme0" -Force
    Set-ItemProperty -Path $zTimestamp0Key.PSPath -Name "MUIVerb" -Value "To .z with timestamp"
    $zTimestamp0CmdKey = New-Item -Path "$zTimestamp0Key\command" -Force
    Set-ItemProperty -Path $zTimestamp0CmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressWithTimestampPs1`" `"%1`" `"zstd`" 0"

    # To .z with timestamp [Extreme] profile
    $zTimestamp00Key = New-Item -Path "$basePath\shell\CompressZTimestampExtreme00" -Force
    Set-ItemProperty -Path $zTimestamp00Key.PSPath -Name "MUIVerb" -Value "To .z with timestamp [Extreme] profile"
    $zTimestamp00CmdKey = New-Item -Path "$zTimestamp00Key\command" -Force
    Set-ItemProperty -Path $zTimestamp00CmdKey.PSPath -Name "(Default)" -Value "powershell -File `"$invokeCompressWithTimestampPs1`" `"%1`" `"zstd`" 1"
}

Write-Host "安装完成！"
    