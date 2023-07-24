Connect-MsolService 

Function Start-Countdown{   
    Param(
        [Int32]$Seconds = 10,
        [string]$Message = "Pausing for 10 seconds..."
    )
    ForEach ($Count in (1..$Seconds))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
}

$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc
$SKU = "SATS1:POWER_BI_PRO"
 
foreach($user in $users) {
    Start-Countdown -Seconds 62 -Message "Wait 62 seconds before next user..."
    New-AzureADMSInvitation -InvitedUserDisplayName $GuestUserName -InvitedUserEmailAddress $GuestUserEmail -InviteRedirectURL https://myapps.microsoft.com -SendInvitationMessage $true
 
}

Connect-AzureAD

Function Start-Countdown{   
    Param(
        [Int32]$Seconds = 10,
        [string]$Message = "Pausing for 10 seconds..."
    )
    ForEach ($Count in (1..$Seconds))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
}

$excelsheet = Read-host "Enter excel csv"
$invitations = import-csv $excelsheet

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello. You are invited to the SATS organization."

$groupname = get-azureadgroup -searchstring "EIMS_TAJ"
$groupnameId = $groupname.ObjectId

foreach ($email in $invitations)
   {New-AzureADMSInvitation `
      -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
      -InvitedUserDisplayName $email.Name `
      -InviteRedirectUrl https://myapps.microsoft.com `
      -InvitedUserMessageInfo $messageInfo `
      -SendInvitationMessage $true
    Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
    $externalemail = $email.ExternalEmail
    $getObjectId = Get-AzureADUser -filter "userprincipalname eq '$externalemail'"
    Add-AzureADGroupMember -ObjectId $groupnameId  -RefObjectId $getObjectId.ObjectId
   }

#https://learn.microsoft.com/en-us/azure/active-directory/external-identities/bulk-invite-powershell
#https://learn.microsoft.com/en-us/powershell/module/azuread/add-azureadgroupmember?view=azureadps-2.0
#https://learn.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0
