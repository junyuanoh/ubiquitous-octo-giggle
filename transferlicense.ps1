Connect-MsolService

$upn1 = "Ayyappan_K@sats.com.sg"
$upn2 = "summer_shayne@sats.com.sg"
Set-MsolUser -UserPrincipalName $upn1 -UsageLocation "SG"
Set-MsolUser -UserPrincipalName $upn2 -UsageLocation "SG"
Set-MsolUserLicense -UserPrincipalName $upn1 -RemoveLicenses "SATS1:POWER_BI_PRO"
Set-MsolUserLicense -UserPrincipalName $upn2 -AddLicenses "SATS1:POWER_BI_PRO"
Get-MsolUser -UserPrincipalName $upn2 | Format-List Licenses, UserPrincipalName