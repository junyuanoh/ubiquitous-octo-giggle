Connect-AzureAD

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
    $var_storeid = Get-AzureADUser -Filter "userPrincipalName eq '$upn'"
    $var_objectid = $var_storeid.objectid
    Start-Countdown -Seconds 15 -Message "Wait 15 seconds before next user..."
    Get-AzureADAuditDirectoryLogs -Filter "targetResources/any(tr:tr/id eq '$var_objectid')" | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\INC000023723557\$upn.csv" -NoTypeInformation
}

### 

$var_objectid = Get-AzureADUser -Filter "userPrincipalName eq '$upn'" | Select-Object ObjectId
Get-AzureADAuditDirectoryLogs -Filter "targetResources/any(tr:tr/id eq '$var_objectid')"