Connect-MsolService 
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$SKU = Read-Host "Enter SKU Name (example: TenantName:LicenseName)"
 
foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Set-MsolUser -UserPrincipalName $upn -UsageLocation "SG"
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU 
    Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName, UsageLocation
}





$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName, UsageLocation
} Export-CSV -path Z:\Downloads\pbiuserlicense.csv