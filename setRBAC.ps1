Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

#Get-mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | ?{$_.RoleAssignmentPolicy -eq "DenyForwardingRoleAssignmentPolicy"} | Export-csv "C:\Users\junyuanoh\OneDrive - SERVBRIDGE INCORPORATED PTE LTD\RBAC_users.csv"
#to list users with specific RBAC role
#Get-mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Export-csv "C:\Users\junyuanoh\OneDrive - SERVBRIDGE INCORPORATED PTE LTD\SATS_users_3.csv"

#Get-mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited | Export-csv "C:\Users\junyuanoh\OneDrive - SERVBRIDGE INCORPORATED PTE LTD\SATS_shared_3.csv"


#Get-Mailbox -RecipientTypeDetails UserMailbox -Filter {ForwardingSmtpAddress -ne $Null} -ResultSize Unlimited | Format-Table DisplayName, ForwardingSmtpAddress, DeliverToMailboxAndForward -AutoSize
#get users who set something in OWA forward

#csv must have UserPrinicpalName in column header 

#Check who is auto forwarding. 
Get-Mailbox -RecipientTypeDetails UserMailbox -Filter {ForwardingSmtpAddress -ne $Null} -ResultSize Unlimited | Format-Table DisplayName, ForwardingSmtpAddress, DeliverToMailboxAndForward, RoleAssignmentPolicy -AutoSize

Get-Mailbox -RecipientTypeDetails SharedMailbox -Filter {ForwardingSmtpAddress -ne $Null} -ResultSize Unlimited | Format-Table DisplayName, ForwardingSmtpAddress, DeliverToMailboxAndForward, RoleAssignmentPolicy -AutoSize


Get-Mailbox -RecipientTypeDetails UserMailbox -Filter {ForwardingSmtpAddress - $Null} -Resultsize unlimited | Export-csv "C:\Users\junyuanoh\OneDrive - SERVBRIDGE INCORPORATED PTE LTD\autoforward_users.csv"

Get-Mailbox -Identity * | FL RoleAssignmentPolicy, UserPrincipalName | Export-csv "C:\Users\junyuanoh\OneDrive - SERVBRIDGE INCORPORATED PTE LTD\RBAC_users.csv"

#Check user RBAC policy
Get-Mailbox -Identity satsvn_junyuanoh | FL UserPrinicipleName, RoleAssigmentPolicy

#Set user to the RBAC policy
Set-Mailbox -Identity James.Ryan -RoleAssignmentPolicy PolicyWithNoEmailForward
Set-Mailbox -RoleAssignmentPolicy "PolicyWithNoEmailForward" -ForwardingSmtpAddress $Null -DeliverToMailboxAndForward $False

#script for bulk RBAC
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline 
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy"
    Get-Mailbox -Identity $upn | FT RoleAssignmentPolicy, UserPrincipalName
}

#script for bulk RBAC + disable PS
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

#new user creation 
Connect-ExchangeOnline -UserPrincipalName satsvn_junyuanoh@sats.com.sg
$upn = Read-Host "Enter UPN" 
Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
Get-Mailbox -Identity $upn | FT RoleAssignmentPolicy, UserPrincipalName
Get-User -Identity $upn | Format-List RemotePowerShellEnabled