Connect-ExchangeOnline
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$group = Read-host "Enter Group"

foreach($user in $users) {
    $upn = $user.UserPrincipalName
    Add-DistributionGroupMember -Identity $group -Member $upn
    Write-Host "Added $upn to $group."
}
Get-DistributionGroupMember -Identity $group | FT DisplayName, PrimarySmtpAddress