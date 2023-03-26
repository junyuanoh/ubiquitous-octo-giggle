Connect-MsolService 
Connect-ExchangeOnline 

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

Function todaydate {
    Get-Date -Format "ddMMyyyy"
}

$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
$SKU = Read-Host "License [Kiosk/E1/E3] (case-insensitive)"
$today = todaydate
$var_password = -join("SATS@",$today) 

If($SKU -eq "Kiosk"){
    Import-Module MSOnline
    foreach($user in $users) {
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Set-MsolUserPrincipalName -UserPrincipalName $oldupn -NewUserPrincipalName $upn
        Set-MsolUser -UserPrincipalName $upn -UsageLocation "SG"
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:EXCHANGEDESKLESS" 
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:POWER_BI_STANDARD" 
        Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName, UsageLocation
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
        $st.RelyingParty = "*"
        $st.State = "Enabled"
        $sta = @($st)
        Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements $sta
        Set-MsolUserPassword -UserPrincipalName $upn -NewPassword $var_password
        $mfauser = Get-MSolUser -UserPrincipalName $upn
        $mfauser.StrongAuthenticationMethods
        Write-Host "$SKU license assigned and MFA enabled for $upn"
    }
    Write-Host "$SKU license assigned and MFA enabled."
    Start-Countdown -Seconds 180 -Message "Wait 3 minutes for license to update before starting next process..."
    #script for bulk RBAC + disable PS + enable litigation hold
    Import-Module ExchangeOnlineManagement
    foreach ($user in $users){
        $upn = $user.UserPrincipalName
        Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
        Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
        Get-Mailbox -Identity $upn | FT UserPrincipalName, RoleAssignmentPolicy
        Get-User -Identity $upn | FT UserPrincipalName, RemotePowerShellEnabled
    }
    Write-Host "$SKU license assignment complete."
    $generatemessage = Read-Host "Generate email for each user? [Y/N]"
    If($generatemessage -eq "Y"){
        foreach ($user in $users){
            $upn = $user.UserPrincipalName
            $theuser = Get-Mailbox -Identity $upn
            $thedisplayname = $theuser.displayname
            $thewin2k = $theuser.UserPrincipalName.trimend('@sats.com.sg')
            $theemail = $theuser.UserPrincipalName
            $message = "`n`nHi SMITH,`n`nThe new account for new staff has been created, assigned $SKU license and enabled MFA.`n`nFull Name: $thedisplayname`nWin2K: $thewin2k`nWin2K Password: $var_password`nEmail: $theemail`nEmail Password: $var_password`n`nPlease advise the users to reset their Win2K password after their first login using this link: https://saml.sats.com.sg/adfs/portal/updatepassword`nYou can set up and change your OWA password via this link: https://www.office.com/`n`nI will now proceed to close the ticket as the request has been fulfilled."
            Write-Host $message
        }
    }
    elseif($generatemessage -eq "N"){
        Write-Host "No message generated"
    }
    else{
        Write-Host "Invalid response"
        Write-Host "No message generated"
    }
}
elseif($SKU -eq "E1"){
    Import-Module MSOnline
    foreach($user in $users) {
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Set-MsolUserPrincipalName -UserPrincipalName $oldupn -NewUserPrincipalName $upn
        Set-MsolUser -UserPrincipalName $upn -UsageLocation "SG"
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:STANDARDPACK" 
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:POWER_BI_STANDARD"
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:RIGHTSMANAGEMENT"
        Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName, UsageLocation
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
        $st.RelyingParty = "*"
        $st.State = "Enabled"
        $sta = @($st)
        Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements $sta
        Set-MsolUserPassword -UserPrincipalName $upn -NewPassword $var_password
        $mfauser = Get-MSolUser -UserPrincipalName $upn
        $mfauser.StrongAuthenticationMethods
        Write-Host "$SKU license assigned and MFA enabled for $upn"
    }
    Start-Countdown -Seconds 180 -Message "Wait 3 minutes for license to update before starting next process..."
    #script for bulk RBAC + disable PS + enable litigation hold
    Import-Module ExchangeOnlineManagement
    foreach ($user in $users){
        $upn = $user.UserPrincipalName
        Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
        Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
        Get-Mailbox -Identity $upn | FT UserPrincipalName, RoleAssignmentPolicy
        Get-User -Identity $upn | FT UserPrincipalName, RemotePowerShellEnabled
    }
    Write-Host "$SKU license assignment complete."
    $generatemessage = Read-Host "Generate email for each user? [Y/N]"
    If($generatemessage -eq "Y"){
        foreach ($user in $users){
            $upn = $user.UserPrincipalName
            $theuser = Get-Mailbox -Identity $upn
            $thedisplayname = $theuser.displayname
            $thewin2k = $theuser.UserPrincipalName.trimend('@sats.com.sg')
            $theemail = $theuser.UserPrincipalName
            $message = "`n`nHi SMITH,`n`nThe new account for new staff has been created, assigned $SKU license and enabled MFA.`n`nFull Name: $thedisplayname`nWin2K: $thewin2k`nWin2K Password: $var_password`nEmail: $theemail`nEmail Password: $var_password`n`nPlease advise the users to reset their Win2K password after their first login using this link: https://saml.sats.com.sg/adfs/portal/updatepassword`nYou can set up and change your OWA password via this link: https://www.office.com/`n`nI will now proceed to close the ticket as the request has been fulfilled."
            Write-Host $message
        }
    }
    elseif($generatemessage -eq "N"){
        Write-Host "No message generated"
    }
    else{
        Write-Host "Invalid response"
        Write-Host "No message generated"
    }
}
elseif($SKU -eq "E3"){
    Import-Module MSOnline
    foreach($user in $users){
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Set-MsolUserPrincipalName -UserPrincipalName $oldupn -NewUserPrincipalName $upn
        Set-MsolUser -UserPrincipalName $upn -UsageLocation "SG"
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:SPE_E3" 
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "SATS1:POWER_BI_STANDARD"
        Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName, UsageLocation
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
        $st.RelyingParty = "*"
        $st.State = "Enabled"
        $sta = @($st)
        Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements $sta
        Set-MsolUserPassword -UserPrincipalName $upn -NewPassword $var_password
        $mfauser = Get-MSolUser -UserPrincipalName $upn
        $mfauser.StrongAuthenticationMethods
        Write-Host "$SKU license assigned and MFA enabled for $upn"
    }
    Start-Countdown -Seconds 180 -Message "Wait 3 minutes for license to update before starting next process..."
    #script for bulk RBAC + disable PS + enable litigation hold
    Import-Module ExchangeOnlineManagement
    foreach ($user in $users){
        $upn = $user.UserPrincipalName
        Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
        Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
        Set-Mailbox $upn -LitigationHoldEnabled $true
        Get-Mailbox -Identity $upn | FT UserPrincipalName, RoleAssignmentPolicy, LitigationHoldEnabled
        Get-User -Identity $upn | FT UserPrincipalName, RemotePowerShellEnabled
    }
    Write-Host "$SKU license assignment complete."
    $generatemessage = Read-Host "Generate email for each user? [Y/N]"
    If($generatemessage -eq "Y"){
        foreach ($user in $users){
            $upn = $user.UserPrincipalName
            $theuser = Get-Mailbox -Identity $upn
            $thedisplayname = $theuser.displayname
            $thewin2k = $theuser.UserPrincipalName.trimend('@sats.com.sg')
            $theemail = $theuser.UserPrincipalName
            $message = "`n`nHi SMITH,`n`nThe new account for new staff has been created, assigned $SKU license and enabled MFA.`n`nFull Name: $thedisplayname`nWin2K: $thewin2k`nWin2K Password: $var_password`nEmail: $theemail`nEmail Password: $var_password`n`nPlease advise the users to reset their Win2K password after their first login using this link: https://saml.sats.com.sg/adfs/portal/updatepassword`nYou can set up and change your OWA password via this link: https://www.office.com/`n`nI will now proceed to close the ticket as the request has been fulfilled."
            Write-Host $message
        }
    }
    elseif($generatemessage -eq "N"){
        Write-Host "No message generated"
    }
    else{
        Write-Host "Invalid response"
        Write-Host "No message generated"
    }
}
else{Write-Host "Invalid response. Script not executed."
}