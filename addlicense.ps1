Connect-MsolService 
Get-MsolAccountSku

$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$SKU = Read-Host "Enter SKU Name (example: TenantName:LicenseName):"
 
foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
    Write-Host "$SKU successfully assigned to $upn"
    Get-MsolUser -UserPrincipalName $upn | Format-List Licenses
}


