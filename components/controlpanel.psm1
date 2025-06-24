<#
.SYNOPSIS
Windows控制面板启动工具模块

.DESCRIPTION
提供通过索引或关键字启动控制面板组件的功能，包含完整参数验证和帮助文档
#>

# 控制面板项映射表（关键字: 启动命令）
$script:ControlPanelItems = @{
    "help"         = "helpctr.exe"                     # 帮助和支持
    "access"       = "control.exe access.cpl"          # 辅助功能选项
    "appmgr"       = "control.exe appwiz.cpl"          # 程序和功能（原程序管理器）
    "display"      = "control.exe desk.cpl"            # 显示设置
    "firewall"     = "wf.msc"                          # Windows Defender 防火墙
    "addhardware"  = "control.exe hdwwiz.cpl"          # 添加硬件向导
    "ie"           = "control.exe inetcpl.cpl"         # Internet选项
    "localization" = "control.exe intl.cpl"            # 区域设置
    "controller"   = "control.exe joy.cpl"             # 游戏控制器
    "audio"        = "control.exe mmsys.cpl"           # 声音设置
    "network"      = "control.exe ncpa.cpl"            # 网络连接
    "netsetup"     = "control.exe netsetup.cpl"        # 网络安装向导
    "usermgr"      = "control.exe nusrmgr.cpl"         # 用户账户
    "nv"           = "${env:ProgramFiles}\NVIDIA Corporation\NVIDIA Control Panel\nvcplui.exe"  # NVIDIA控制面板
    "igfx"         = "${env:ProgramFiles(x86)}\Intel\Intel(R) Graphics Command Center\igfxCC.exe"  # Intel显卡控制中心（新版）
    "odbc"         = "odbcad32.exe"                    # ODBC数据源管理器
    "sys"          = "control.exe sysdm.cpl"           # 系统属性
    "security"     = "control.exe wscui.cpl"           # 操作中心（原安全中心）
    "autoupdate"   = "wuapp.exe"                       # Windows更新
}

# 索引顺序列表（与用户示例索引对应）
$script:IndexOrder = @(
    "help", "access", "appmgr", "display", "firewall", 
    "addhardware", "ie", "localization", "controller", 
    "audio", "network", "netsetup", "usermgr", "nv", 
    "igfx", "odbc", "sys", "security", "autoupdate"
)

function Show-ControlPanelList {
    <#
    .SYNOPSIS
    显示所有控制面板项的索引列表
    #>
    Write-Host "Windows 控制面板组件列表:`n" -ForegroundColor Cyan
    $script:IndexOrder | ForEach-Object -Begin { $i = 0 } -Process {
        $key = $_
        $desc = switch($key) {
            "help"         { "帮助和支持" }
            "access"       { "辅助功能选项" }
            "appmgr"       { "程序和功能" }
            "display"      { "显示设置" }
            "firewall"     { "Windows Defender 防火墙" }
            "addhardware"  { "添加硬件向导" }
            "ie"           { "Internet选项" }
            "localization" { "区域设置" }
            "controller"   { "游戏控制器" }
            "audio"        { "声音设置" }
            "network"      { "网络连接" }
            "netsetup"     { "网络安装向导" }
            "usermgr"      { "用户账户" }
            "nv"           { "NVIDIA控制面板" }
            "igfx"         { "Intel显卡控制中心" }
            "odbc"         { "ODBC数据源管理器" }
            "sys"          { "系统属性" }
            "security"     { "操作中心" }
            "autoupdate"   { "Windows更新" }
        }
        Write-Host ("{0,-2} `e[32m{1,-16}`e[0m `e[33m{2}`e[0m" -f $i++, $key, $desc)
    }
    Write-Host "`n使用示例:`n  Get-ControlPanel -List`n  Get-ControlPanel -Index 2`n  Get-ControlPanel -Keyword audio" -ForegroundColor DarkGray
}

function Get-ControlPanel {
    <#
    .SYNOPSIS
    启动指定的控制面板组件
    
    .PARAMETER Index
    控制面板项的数字索引（0-18）
    
    .PARAMETER Keyword
    控制面板项的关键字（如audio、firewall）
    
    .PARAMETER List
    显示所有控制面板项列表
    
    .EXAMPLE
    Get-ControlPanel -Index 2
    启动程序和功能控制面板
    
    .EXAMPLE
    Get-ControlPanel -Keyword audio
    启动声音设置控制面板
    
    .EXAMPLE
    Get-ControlPanel -List
    显示所有控制面板项列表
    #>
    [CmdletBinding(DefaultParameterSetName='ByIndex')]
    param(
        [Parameter(ParameterSetName='ByIndex', Position=0)]
        # [ValidateRange(0, ($script:IndexOrder.Count))]
        [ValidateRange(0, 17)]
        [int]$Index,

        [Parameter(ParameterSetName='ByKeyword', Position=0)]
        [string]$Keyword,

        [Parameter(ParameterSetName='List')]
        [switch]$List
    )

    if ($List) {
        Show-ControlPanelList
        return
    }

    try {
        $key = if ($PSCmdlet.ParameterSetName -eq 'ByIndex') {
            $script:IndexOrder[$Index]
        } else {
            $Keyword
        }

        $execPath = $script:ControlPanelItems[$key]
        if (-not (Test-Path $execPath -PathType Leaf)) {
            if ($key -in "nv", "igfx") {
                Write-Warning "未检测到$key控制面板程序，可能未安装对应硬件驱动"
                return
            }
            throw "控制面板项启动程序不存在：$execPath"
        }

        Start-Process -FilePath $execPath
    }
    catch {
        Write-Error "操作失败：$_"
        Write-Host "`n使用 Get-ControlPanel -List 查看完整控制面板项列表" -ForegroundColor DarkGray
    }
}

Export-ModuleMember -Function Get-ControlPanel, Show-ControlPanelList
