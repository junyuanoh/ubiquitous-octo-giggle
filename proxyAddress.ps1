#Script to Change the E-mail, Description, and ProxyAddress Attributes: 
$User = Get-ADUser -Identity "satsvn_junyuanoh"
Set-ADUser $User -EmailAddress "junyuan@sats.com.sg" -Description "New user description" -Add @{proxyaddresses="SMTP:newemail@domain.com"}

#Script to Add User To Group:
$Group = Get-ADGroup -Identity "GroupName"
Add-ADGroupMember -Identity $Group -Members "username"

Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline 
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
    Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
    Get-Mailbox -Identity $upn | FT RoleAssignmentPolicy, UserPrincipalName 
    Get-User -Identity $upn | Format-List RemotePowerShellEnabled
}