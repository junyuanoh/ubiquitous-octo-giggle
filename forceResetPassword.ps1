Connect-MsolService

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Set-MsolUserPassword -UserPrincipalName $upn -ForceChangePasswordOnly $true -ForceChange
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
    Set-MsolUserPassword -UserPrincipalName user@domain.com -ForceChangePasswordOnly $true -ForceChange
    Get-AzureADAuditDirectoryLogs -Filter "targetResources/any(tr:tr/UserPrincipalName eq '$upn')" | Export-Csv -Path "\\Mac\Home\Desktop\AD Scripts\$upn.csv" -NoTypeInformation
}