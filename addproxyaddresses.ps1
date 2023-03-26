Import-module ActiveDirectory
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

foreach($user in $users) {
    $upn = $user.UserPrincipalName
    $proxy = $user.EmailAddress
    Set-ADUser $upn -add @{ProxyAddresses= $proxy}
    Get-ADUser $upn -Properties ProxyAddresses | select Name, ProxyAddresses
}


Import-module ActiveDirectory
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

foreach($user in $users) {
    $upn = $user.UserPrincipalName
    $proxy = $user.EmailAddress
    Set-ADUser $upn -add @{ProxyAddresses= $proxy}
   

Import-Module ActiveDirectory

$csvloc = Read-Host "Enter path to .csv" 
# Import users from CSV
Import-Csv $csvloc | ForEach-Object {
$samAccountName = $_."samAccountName"
$company = $_."company"

if (Get-ADUser -F {SamAccountName -eq $samAccountName} ){

Set-AdUser -Identity $samAccountName -Company $company
Get-ADUser $samAccountName -Properties UserPrincipalName,Company | Select  UserPrincipalName,Company
    }
else{
Write-Host $samAccountName " does not exist.Please check user details" "`n `n `n"   
    }
}