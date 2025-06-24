Function Global:Get-DateDetails {
    # $date = Get-Date -Format "MM/dd/yyyy dddd HH:mm:ss K"
    $month = Get-Date -Format "MMM"
    $day = Get-Date -Format "dd"
    $year = Get-Date -Format "yyyy"
    # $weekdays = Get-Date -Format "dddd"
    $weeks = Get-Date -UFormat %V
    $time_zone = Get-Date -Format "K "
    $hour = Get-Date -Format "HH"
    $minute = Get-Date -Format "mm"
    $second = Get-Date -Format "ss"
    $millisec = Get-Date -Format "fffffff"
    Write-Host ($month + ". " + $day + ", " + $year + "  ") -ForegroundColor DarkCyan -NoNewline
    Write-Host ("week-" + $weeks + "  ") -ForegroundColor DarkMagenta -NoNewline
    Write-Host ($hour + ":" + $minute + ":" + $second) -ForegroundColor Green -NoNewline
    Write-Host ("." + $millisec + "  ") -ForegroundColor DarkGray -NoNewline
    Write-Host ("GMT" + $time_zone) -ForegroundColor DarkYellow

}

Function Global:Format-Time {
    param(
        [Parameter(Mandatory = $true)]
        [int]$value,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Days", "Hours", "Minutes", "Seconds", "Milliseconds")]
        [string]$Unit = "Seconds"
    )
    switch ($Unit) {
        "Days" {
            $timespan = New-Object TimeSpan $value, 0, 0, 0
        }
        "Hours" {
            $timespan = New-Object TimeSpan 0, $value, 0, 0
        }
        "Minutes" {
            $timespan = New-Object TimeSpan 0, 0, $value, 0
        }
        "Seconds" {
            $timespan = New-Object TimeSpan 0, 0, 0, $value
        }
        "Milliseconds" {
            $timespan = New-Object TimeSpan 0, 0, 0, 0, $value
        }
        default {
            Write-Error "Invalid time unit specified. Defaulting to Seconds."
        }
    }
    #$formattedTime = "{0:D2}:{1:D2}:{2:D2}" -f $timespan.Hours, $timespan.Minutes, $timespan.Seconds
    
    return $timespan
}

Function Global:Show-Calendar {
    param(
        [DateTime] $start = [DateTime]::Today,
        [DateTime] $end = $start,
        $firstDayOfWeek,
        [int[]] $highlightDay,
        [string[]] $highlightDate = [DateTime]::Today.ToString('yyyy-MM-dd')
    )

    ## Determine the first day of the start and end months.
    $start = New-Object DateTime $start.Year, $start.Month, 1
    $end = New-Object DateTime $end.Year, $end.Month, 1

    ## Convert the highlighted dates into real dates.
    [DateTime[]] $highlightDate = [DateTime[]] $highlightDate

    ## Retrieve the DateTimeFormat information so that the
    ## calendar can be manipulated.
    $dateTimeFormat = (Get-Culture).DateTimeFormat
    if ($firstDayOfWeek) {
        $dateTimeFormat.FirstDayOfWeek = $firstDayOfWeek
    }

    $currentDay = $start

    ## Process the requested months.
    while ($start -le $end) {
        ## Return to an earlier point in the function if the first day of the month
        ## is in the middle of the week.
        while ($currentDay.DayOfWeek -ne $dateTimeFormat.FirstDayOfWeek) {
            $currentDay = $currentDay.AddDays(-1)
        }

        ## Prepare to store information about this date range.
        $currentWeek = New-Object PsObject
        $dayNames = @()
        $weeks = @()

        ## Continue processing dates until the function reaches the end of the month.
        ## The function continues until the week is completed with
        ## days from the next month.
        while (($currentDay -lt $start.AddMonths(1)) -or
        ($currentDay.DayOfWeek -ne $dateTimeFormat.FirstDayOfWeek)) {
            ## Determine the day names to use to label the columns.
            $dayName = "{0:ddd}" -f $currentDay
            if ($dayNames -notcontains $dayName) {
                $dayNames += $dayName
            }

            ## Pad the day number for display, highlighting if necessary.
            $displayDay = " {0,2} " -f $currentDay.Day

            ## Determine whether to highlight a specific date.
            if ($highlightDate) {
                $compareDate = New-Object DateTime $currentDay.Year,
                $currentDay.Month, $currentDay.Day
                if ($highlightDate -contains $compareDate) {
                    $displayDay = "*" + ("{0,2}" -f $currentDay.Day) + "*"
                }
            }

            ## Otherwise, highlight as part of a date range.
            if ($highlightDay -and ($highlightDay[0] -eq $currentDay.Day)) {
                $displayDay = "[" + ("{0,2}" -f $currentDay.Day) + "]"
                $null, $highlightDay = $highlightDay
            }

            ## Add the day of the week and the day of the month as note properties.
            $currentWeek | Add-Member NoteProperty $dayName $displayDay

            ## Move to the next day of the month.
            $currentDay = $currentDay.AddDays(1)

            ## If the function reaches the next week, store the current week
            ## in the week list and continue.
            if ($currentDay.DayOfWeek -eq $dateTimeFormat.FirstDayOfWeek) {
                $weeks += $currentWeek
                $currentWeek = New-Object PsObject
            }
        }

        ## Format the weeks as a table.
        $calendar = $weeks | Format-Table $dayNames -AutoSize | Out-String

        ## Add a centered header.
        $width = ($calendar.Split("`n") | Measure-Object -Maximum Length).Maximum
        $header = "{0:MMMM yyyy}" -f $start
        $padding = " " * (($width - $header.Length) / 2)
        $displayCalendar = " `n" + $padding + $header + "`n " + $calendar
        $displayCalendar.TrimEnd()

        ## Move to the next month.
        $start = $start.AddMonths(1)

    }
}

Function Global:Sync-Time {
    sudo { w32tm /resync }
    w32tm /query /status /verbose
}

Set-Alias -Name "Get-Now" -Value Get-DateDetails -Option AllScope -Scope Global
Set-Alias -Name "time" -Value Get-DateDetails -Option AllScope -Scope Global
Set-Alias -Name "date" -Value Get-DateDetails -Option AllScope -Scope Global
Set-Alias -Name "calendar" -Value Show-Calendar -Option AllScope -Scope Global