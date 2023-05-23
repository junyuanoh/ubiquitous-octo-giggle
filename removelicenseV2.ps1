Connect-MsolService 
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$SKU = Read-Host "Enter SKU Name (example: TenantName:LicenseName)"
 
foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicenses $SKU
    Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:POWER_BI_STANDARD" 
}

# $upn1 should be the old account, to be unassigned PBI Pro license. 
$upn1 = "CheeLoong_Lee@sats.com.sg"
# $upn2 should be the account to be assigned PBI Pro license. 
$upn2 = "eeling_loh@sats.com.sg"
Set-MsolUser -UserPrincipalName $upn1 -UsageLocation "SG"
Set-MsolUser -UserPrincipalName $upn2 -UsageLocation "SG"
Set-MsolUserLicense -UserPrincipalName $upn1 -RemoveLicenses "SATS1:POWER_BI_PRO"
Set-MsolUserLicense -UserPrincipalName $upn2 -AddLicenses "SATS1:POWER_BI_PRO"
Get-MsolUser -UserPrincipalName $upn2 | Format-List Licenses, UserPrincipalName
