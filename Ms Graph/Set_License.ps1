#Authentication to modules
Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All
Connect-ExchangeOnline 

#Function for countdown and DDMMYYYY current date
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

#Setup context
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
$SKU = Read-Host "License [Kiosk/E1/E3] (case-insensitive)"


#Bulk of Code
If($SKU -eq "Kiosk"){
    Import-Module Microsoft.Graph.Users
    foreach($user in $users) {
        Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Update-MgUser -UserId $oldupn -UserPrincipalName $upn
        
        Update-MgUser -UserId $upn -UsageLocation "SG"
        #ExchangeKioskSKU
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "80b2d799-d2ba-4d2a-8842-fb0d0f3a4b82"} -RemoveLicenses @() 
        #PowerBIStandardSKU
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "a403ebcc-fae0-4ca2-8c8c-7a907fd6c235"} -RemoveLicenses @()

        Get-MgUser -UserId $upn | Format-Table UserPrincipalName
        Get-MgUserLicenseDetail -UserId $upn | Format-Table SkuPartNumber

        Write-Host "$SKU license assigned for $upn"
    }
    Start-Countdown -Seconds 180 -Message "Wait 3 minutes for license to update before starting next process..."
    #script for bulk RBAC + disable PS + enable litigation hold
    Import-Module ExchangeOnlineManagement
    foreach ($user in $users){
        $upn = $user.UserPrincipalName
        Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
        Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
        Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
        Get-Mailbox -Identity $upn | FT UserPrincipalName, RoleAssignmentPolicy
        Get-User -Identity $upn | FT UserPrincipalName, RemotePowerShellEnabled
    }
}

elseif($SKU -eq "E1"){
    Import-Module Microsoft.Graph.Users
    foreach($user in $users) {
        Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Update-MgUser -UserId $oldupn -UserPrincipalName $upn
        Update-MgUser -UserId $upn -UsageLocation "SG"

        #E1
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "18181a46-0d4e-45cd-891e-60aabd171b4e"} -RemoveLicenses @() 
        #PowerBIStandardSKU
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "a403ebcc-fae0-4ca2-8c8c-7a907fd6c235"} -RemoveLicenses @()
        #AIP
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "c52ea49f-fe5d-4e95-93ba-1de91d380f89"} -RemoveLicenses @()

        Get-MgUser -UserId $upn | Format-Table UserPrincipalName
        Get-MgUserLicenseDetail -UserId $upn | Format-Table SkuPartNumber

        Write-Host "$SKU license assigned for $upn"
    }
    Start-Countdown -Seconds 180 -Message "Wait 3 minutes for license to update before starting next process..."
    #script for bulk RBAC + disable PS + enable litigation hold
    Import-Module ExchangeOnlineManagement
    foreach ($user in $users){
        $upn = $user.UserPrincipalName
        Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
        Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
        Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
        Get-Mailbox -Identity $upn | FT UserPrincipalName, RoleAssignmentPolicy
        Get-User -Identity $upn | FT UserPrincipalName, RemotePowerShellEnabled
    }
}

elseif($SKU -eq "E3"){
    Import-Module Microsoft.Graph.Users
    foreach($user in $users){

        Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Update-MgUser -UserId $oldupn -UserPrincipalName $upn
        Update-MgUser -UserId $upn -UsageLocation "SG"

        #E3
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "05e9a617-0261-4cee-bb44-138d3ef5d965"} -RemoveLicenses @() 
        #PowerBIStandardSKU
        Set-MgUserLicense -UserId $upn -AddLicenses @{SkuId = "a403ebcc-fae0-4ca2-8c8c-7a907fd6c235"} -RemoveLicenses @()

        Get-MgUser -UserId $upn | Format-Table UserPrincipalName
        Get-MgUserLicenseDetail -UserId $upn | Format-Table SkuPartNumber

        Write-Host "$SKU license assigned for $upn"
    }
    Start-Countdown -Seconds 180 -Message "Wait 3 minutes for license to update before starting next process..."
    #script for bulk RBAC + disable PS + enable litigation hold
    Import-Module ExchangeOnlineManagement
    foreach ($user in $users){
        $upn = $user.UserPrincipalName
        Start-Countdown -Seconds 3 -Message "Wait 3 seconds before next user..."
        Set-Mailbox -Identity $upn -RoleAssignmentPolicy "DenyForwardingRoleAssignmentPolicy" -Confirm:$false
        Set-User -Identity $upn -RemotePowerShellEnabled $false -Confirm:$false
        Set-Mailbox $upn -LitigationHoldEnabled $true
        Get-Mailbox -Identity $upn | FT UserPrincipalName, RoleAssignmentPolicy, LitigationHoldEnabled
        Get-User -Identity $upn | FT UserPrincipalName, RemotePowerShellEnabled
    }
    Write-Host "$SKU license assignment complete."
}
else{Write-Host "Invalid response. Script not executed."
}