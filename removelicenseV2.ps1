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

$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$SKU = "SATS1:POWER_BI_PRO"
 
foreach($user in $users) {
    Start-Countdown -Seconds 62 -Message "Wait 62 seconds before next user..."
    $upn = $user.UserPrincipalName 
    Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicenses $SKU
    Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName
}

# $upn1 should be the old account, to be unassigned PBI Pro license. 
$upn1 = "Xi_Zhang@sats.com.sg"
# $upn2 should be the account to be assigned PBI Pro license. 
$upn2 = "joe_zhangzc@sats.com.sg"
Set-MsolUser -UserPrincipalName $upn1 -UsageLocation "SG"
Set-MsolUser -UserPrincipalName $upn2 -UsageLocation "SG"
Set-MsolUserLicense -UserPrincipalName $upn1 -RemoveLicenses "SATS1:POWER_BI_PRO"
Set-MsolUserLicense -UserPrincipalName $upn2 -AddLicenses "SATS1:POWER_BI_PRO"
Get-MsolUser -UserPrincipalName $upn2 | Format-List Licenses, UserPrincipalName
