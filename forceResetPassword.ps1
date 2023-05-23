Connect-MsolService

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Set-MsolUserPassword -UserPrincipalName $upn -ForceChangePasswordOnly $true -ForceChangePassword $true
    Write-Host "Force password reset for $upn"
}

# force reset + get logs
Connect-AzureAD
Connect-MsolService

Function Start-Countdown{   
    Param(
        [Int32]$Seconds = 10,
        [string]$Message = "Pausing for 10 seconds..."
    )
    ForEach ($Count in (1..$Seconds))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
}


$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Start-Countdown -Seconds 5 -Message "Wait 5 seconds before next user..."
    Set-MsolUserPassword -UserPrincipalName $upn -ForceChangePasswordOnly $true -ForceChangePassword $true
    Get-AzureADAuditDirectoryLogs -Filter "targetResources/any(tr:tr/UserPrincipalName eq '$upn')" | Export-Csv -Path "\\Mac\Home\Desktop\AD Scripts\$upn.csv" -NoTypeInformation
}

###

# Set the domain admin account name
$accountName = "satsaddom\sats_taskrunner"

# Get all scheduled tasks on all servers in the domain
$servers = Get-ADComputer -Filter {OperatingSystem -Like "Windows Server*"}
$tasks = foreach ($server in $servers) {
    $computerName = $server.Name
    Get-ScheduledTask -CimSession $computerName -TaskPath "\Microsoft\Windows" -ErrorAction SilentlyContinue |
        Where-Object {$_.Principal.UserId -eq $accountName} |
        Select-Object @{Name="Server";Expression={$computerName}},TaskName,TaskPath
}

# Display the servers where the task is scheduled
if ($tasks) {
    $tasks | Format-Table -AutoSize
} else {
    Write-Host "The task is not scheduled on any server in the domain."
}


# Set the domain admin account name
$accountName = "satsaddom\sats_taskrunner"

# Set the server name
$serverName = "SINDC2DC2K16P01"

# Get scheduled tasks on the specified server
$tasks = Get-ScheduledTask -CimSession $serverName |
         Where-Object {$_.Principal.UserId -eq $accountName} |
         Select-Object @{Name="Server";Expression={$serverName}}, TaskName, TaskPath

# Display the scheduled tasks on the server
if ($tasks) {
    $tasks | Format-Table -AutoSize
} else {
    Write-Host "The task is not scheduled on the specified server."
}


####

# Set the server name
$serverName = "SINDC2DC2K16P01"

# Get all scheduled tasks on the server
$tasks = Get-ScheduledTask -CimSession $serverName 

# Display the scheduled tasks
if ($tasks) {
    $tasks | Format-Table -AutoSize
} else {
    Write-Host "No scheduled tasks found on the server."
}

Get-DhcpServerv4OptionValue -ComputerName 10.18.20.27 -ScopeId 10.67.197.0/24

get-dhcpserverv4optionvalue -computername SINDC1SM2K16P06 -ScopeId 10.67.197.0