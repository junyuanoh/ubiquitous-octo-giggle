

Import-Module ActiveDirectory
$mailbox = Read-Host "Enter DL UPN or samaccountname"
$csvloc = Read-Host "Enter path to .csv" 
Import-Csv $csvloc | ForEach-Object {
    $UserPrincipalName = $_."UserPrincipalName"

    if (Get-ADUser -F {SamAccountName -eq $UserPrincipalName}){
        Remove-ADGroupMember -Identity $mailbox -Members $UserPrincipalName -Confirm:$false
        Get-ADUser $UserPrincipalName -Properties UserPrincipalName | Select UserPrincipalName
    }
    else{
        Write-Host $UserPrincipalName "does not exist. Please check user details." "`n `n `n"
    }
}

####

$csvloc = Read-Host "Enter path to .csv" 
$mailbox = Read-Host "Enter DL UPN"
$users = Import-Csv $csvloc
foreach($user in $users) {
    $upn = $user.UserPrincipalName 
    Remove-ADGroupMember -Identity $mailbox -Members $upn -Confirm:$false
    Get-ADUser $upn -Properties UserPrincipalName | Select UserPrincipalName
}

####

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
