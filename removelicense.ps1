Connect-MsolService -Credential $Credentials
$users = Import-Csv .\Users-to-disable.csv
 
foreach ($user in $users) {
Write-Verbose "Processing licenses for user $($user.UserPrincipalName)"
try { $user = Get-MsolUser -UserPrincipalName $user.UserPrincipalName -ErrorAction Stop }
catch { continue }
 
$SKUs = @($user.Licenses)
if (!$SKUs) { Write-Verbose "No Licenses found for user $($user.UserPrincipalName), skipping..." ; continue }
 
foreach ($SKU in $SKUs) {
if ($SKU.AccountSkuId -ne “SATS1:EXCHANGEDESKLESS”) { continue }
if (($SKU.GroupsAssigningLicense.Guid -ieq $user.ObjectId.Guid) -or (!$SKU.GroupsAssigningLicense.Guid)) {
Write-Verbose "Removing license $($Sku.AccountSkuId) from user $($user.UserPrincipalName)"
Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -RemoveLicenses $SKU.AccountSkuId
}
else {
Write-Verbose "License $($Sku.AccountSkuId) is assigned via Group, use the Azure AD blade to remove it!"
continue
}
}
}