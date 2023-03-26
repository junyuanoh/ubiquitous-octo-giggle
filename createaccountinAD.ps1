New-ADUser -WhatIf -Name "Testing Account" -GivenName -Surname -DisplayName -SamAccountName "Testing123_Testing987" -UserPrincipalName "Testing123_Testing987" -Path "OU=SATSChina,DC=satsnet,DC=com,DC=sg" -EmailAddress -EmployeeNumber -Title -Department -Company -Description -Office -AccountPassword (ConvertTo-SecureString “SATS@22112022” -AsPlainText -force) -ChangePasswordAtLogon $True -Enabled $true 

New-ADUser -Name "Testing Account" -SamAccountName "Testing12_Testing98" -UserPrincipalName "Testing12_Testing98" -Path "OU=SATSChina,DC=satsnet,DC=com,DC=sg" -EmailAddress "Testing12_Testing98@sats.com.sg" -EmployeeNumber "99999999" -Title "TestingTitle" -Department "TestingDepartment" -Company "TestingCompany" -Description "TestingDescription" -Office "TestingOffice" -AccountPassword (ConvertTo-SecureString “SATS@22112022” -AsPlainText -force) -ChangePasswordAtLogon $True -Enabled $true 

Import-Module activedirectory

function todaydate {
    Get-Date -Format "ddMMyyyy"
}
$var_company = (Read-Host "Company").Trim()
function getemail {
    if($var_company -eq "SATS Airport Services Pte Ltd"){
        "@sats.com.sg"
    }
    elseif($var_company -eq "SATS Catering Pte Ltd"){
        "@sats.com.sg"
    }
    elseif($var_company -eq "SATS Food Services Pte Ltd"){
        "@sats.com.sg"
    }
    elseif($var_company -eq "SATS Asia-Pacific Star Private Limited"){
        "@sats.com.sg"
    }
    elseif($var_company -eq "GTRSG Pte. Ltd."){
        "@gtr.com.sg"
    }
    elseif($var_company -eq "SATS Ltd"){
        "@sats.com.sg"
    }
    elseif($var_company -eq "SATS Security Services Private Limited"){
        "@sats.com.sg"
    }
    elseif($var_company -eq "Country Foods Pte. Ltd."){
        "@countryfoods.com"
    }
    elseif($var_company -eq "SATS China Co., Ltd"){
        "@satschina.com"
    }
    elseif($var_company -eq "SATS Food Solutions Thailand Co., Ltd."){
        "@satsthailand.com"
    }
    else{
        "@sats.com.sg"
        Write-Host "*Company name not found. Using @sats.com.sg domain"
    }
}
function getou {
    if($var_company -eq "SATS Airport Services Pte Ltd"){
        "OU=SAS,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS Catering Pte Ltd"){
        "OU=SCC,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS Food Services Pte Ltd"){
        "OU=SFI,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS Asia-Pacific Star Private Limited"){
        "OU=GWZ,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "GTRSG Pte. Ltd."){
        "OU=SGSS,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS Ltd"){
        "OU=SHC,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS Security Services Private Limited"){
        "OU=SSS,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "Country Foods Pte. Ltd."){
        "OU=SATSBRF,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS China Co., Ltd"){
        "OU=SATSChina,DC=satsnet,DC=com,DC=sg"
    }
    elseif($var_company -eq "SATS Food Solutions Thailand Co., Ltd."){
        "OU=SATSThailand,DC=satsnet,DC=com,DC=sg"
    }
    else{
        "OU=SAS,DC=satsnet,DC=com,DC=sg"
        Write-Host "*Company name not found. Adding in SAS OU..."
    }
}
function getgroup {
    if($var_company -eq "SATS Airport Services Pte Ltd"){
        "SAS_Proxy", "SAS_AllUsersGroup", "SAS_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk"
    }
    elseif($var_company -eq "SATS Catering Pte Ltd"){
        "SCC_Proxy", "SCC_AllUsersGroup", "SCC_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk", "SG SCC General Staff", "SCC_General_ACL"
    }
    elseif($var_company -eq "SATS Food Services Pte Ltd"){
        "SFI_Proxy", "SFI_AllUsersGroup", "SFI_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk", "SG SFI General Staff", "SFI_General_ACL"
    }
    elseif($var_company -eq "SATS Asia-Pacific Star Private Limited"){
        "SAS_Proxy", "GWZ_AllUsersGroup", "SAS_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk", "SG GWZ General Staff", "GWZ_General_ACL"
    }
    elseif($var_company -eq "GTRSG Pte. Ltd."){
        "SAS_Proxy", "SGSS_AllUsersGroup", "SAS_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk", "SG SGSS General Staff", "SGSS_General_ACL"
    }
    elseif($var_company -eq "SATS Ltd"){
        "SHC_Proxy", "SHC_AllUsersGroup", "SHC_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk", "SG SHC General Staff", "SHC_General_ACL"
    }
    elseif($var_company -eq "SATS Security Services Private Limited"){
        "SSS_Proxy", "SSS_AllUsersGroup", "SSS_PrintGroup", "Sats_Kiosk_ACL", "SATS Kiosk", "SG SSS General Staff", "SSS_General_ACL"
    }
    elseif($var_company -eq "Country Foods Pte. Ltd."){
        "SFI_Proxy", "SFI_AllUsersGroup", "SFI_PrintGroup", "SATSBRF_Proxy", "SATSBRF_AllUsersGroup", "SATSBRF_PrintGroup", "SG SATSBRF General Staff", "SATSBRF_General_ACL", "SATS_Outlook_ACL", "SATS Outlook", "SATS_AIP_Users", "SG CF All Users Group", "CF_AllUsersGroup"
    }
    elseif($var_company -eq "SATS China Co., Ltd"){
        "SATS_Outlook_ACL", "SATS Outlook", "SATS_AIP_Users", "SATS China Trading Notifications"
    }
    elseif($var_company -eq "SATS Food Solutions Thailand Co., Ltd."){
        "SATS_Outlook_ACL", "SATS Outlook", "SATS_AIP_Users", "SHC_Proxy", "SHC_AllUsersGroup", "SHC_PrintGroup","SATSThailand All Users Group","SATSThailand_AllUsers"
    }
    else{
        Write-Host "*Company name not found. No groups added."
    }
}

$today = todaydate
$var_givenname = (Read-Host "First Name").Trim()
$var_surname = (Read-Host "Last Name").Trim()
$var_fullname = -join($var_givenname," ",$var_surname)
while ($true){
    $var_samaccountname = (Read-Host "Username").Trim()
    if ($var_samaccountname.length -gt 20){
        Write-Host "Username greater than 20 characters."
    }
    elseif (Get-ADUser -F {SamAccountName -eq $var_samaccountname}){
        Write-Host "A user account with username $var_samaccountname already exist in Active Directory."
    }
    else{
        break
    }
}
$var_upn = -join($var_samaccountname,"@satsnet.com.sg")
$var_getemail = getemail
$var_emailaddress = "$var_samaccountname$var_getemail"
$var_ou = getou
$var_office = (Read-Host "Office").Trim()
$var_description = -join("Created by: Jun Yuan, ",$today)
$var_password = -join("SATS@",$today)

New-ADUser -Name $var_fullname -SamAccountName $var_samaccountname -GivenName $var_givenname -Surname $var_surname -UserPrincipalName $var_upn -Path $var_ou -EmailAddress $var_emailaddress -EmployeeNumber "99999999" -Title "TestingTitle" -Department "TestingDepartment" -Company "TestingCompany" -Description $var_description -Office $var_office -AccountPassword (ConvertTo-SecureString $var_password -AsPlainText -force) -ChangePasswordAtLogon $True -Enabled $true 

$groups = getgroup
foreach($group in $groups){
    Add-ADGroupMember -Identity $group -Members $var_samaccountname
}

# AAD Provision

Connect-MsolService
Write-Host "`nEnsure that .csv file used has 'UserPrincipalName' in the first column and row, followed by name@domain.com after each row.`n"
$csvloc = Read-Host "Enter path to .csv" 
$users = Import-Csv $csvloc

### above for input, below for hard code 


$users = Import-Csv \\Mac\Home\Desktop\PSScriptCSVs\BulkUpdateMFA.csv
  
foreach ($user in $users)
  
{
    $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $st.RelyingParty = "*"
    $st.State = "Enabled"
    $sta = @($st)
    Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements $sta
}
  
Write-Host "DONE RUNNING SCRIPT"
  
Read-Host -Prompt "Press Enter to exit"

$st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$st.RelyingParty = "*"
$st.State = "Enabled"
$sta = @($st)
Set-MsolUser -UserPrincipalName $var_samaccountname -StrongAuthenticationRequirements $sta
Get-MsolUser -UserPrincipalName $var_samaccountname | FL UserPrincipalName, -StrongAuthenticationRequirements

Write-Host "$samaccountname
dd"