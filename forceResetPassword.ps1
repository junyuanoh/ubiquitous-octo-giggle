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
    Write-Host "Force password reset for $upn"
}

# force reset + get logs
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

Connect-AzureAD
Connect-MsolService

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Start-Countdown -Seconds 5 -Message "Wait 5 seconds before next user..."
    Set-MsolUserPassword -UserPrincipalName $upn -ForceChangePasswordOnly $true -ForceChangePassword $true
    Start-Countdown -Seconds 2 -Message "Wait 5 seconds before next user..."
    Set-MsolUserPassword -UserPrincipalName $upn -ForceChangePasswordOnly $true -ForceChangePassword $true
}
Start-Countdown -Seconds 300 -Message "Wait 300 seconds before next export action..."

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-AzureADAuditDirectoryLogs -Filter "targetResources/any(tr:tr/UserPrincipalName eq '$upn')" | Export-Csv -Path ""C:\Users\Administrator\Desktop\$upn.csv"" -NoTypeInformation
}

####

#for MG Graph
Connect-MgGraph -Scope AuditLog.Read.All
$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-MgAuditLogDirectoryAudit -filter "TargetResources/any(t:t/UserPrincipalName eq '$upn') and ActivityDisplayName eq 'Set force change user password'" | Export-Csv -Path "C:\Users\Administrator\Desktop\$upn.csv" -NoTypeInformation
}