Function Global:Enable-Proxy {
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 1
    Write-Host "Proxy Enabled" -ForegroundColor Green
}

Function Global:Disable-Proxy {
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 0
    Write-Host "Proxy Disabled" -ForegroundColor Red
}

Function Global:Get-Proxy {
    Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
}
