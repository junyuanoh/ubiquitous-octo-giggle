<#
=============================================================================================
Name:           Get MFA Status Report
Description:    Gets MFA status for all users and authentication methods
Version:        1.0
Website:        activedirectorypro.com
Script by:      activedirectorypro.com
Instructions:   https://activedirectorypro.com/mfa-status-powershell
============================================================================================
#>

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$usersprep = Import-Csv $csvloc2

$users = ForEach ($mguser in $usersprep) {
    $upn = $mguser.UserPrincipalName
    get-mguser -userid $upn
    }

$results=@();
Write-Host  "`nRetreived $($users.Count) users";
#loop through each user account
foreach ($user in $users) {

Write-Host  "`n$($user.UserPrincipalName)";
$myObject = [PSCustomObject]@{
    user               = "-"
    MFAstatus          = "_"
    email              = "-"
    app                = "-"
    password           = "-"
    phone              = "-"
}

$MFAData=Get-MgUserAuthenticationMethod -UserId $user.UserPrincipalName #-ErrorAction SilentlyContinue

$myobject.user = $user.UserPrincipalName;
    #check authentication methods for each user
    ForEach ($method in $MFAData) {
    
        Switch ($method.AdditionalProperties["@odata.type"]) {
          "#microsoft.graph.emailAuthenticationMethod"  { 
             $myObject.email = $true 
             $myObject.MFAstatus = "Enabled"
          } 
          "#microsoft.graph.microsoftAuthenticatorAuthenticationMethod"  { 
            $myObject.app = $true 
            $myObject.MFAstatus = "Enabled"
          }    
          "#microsoft.graph.passwordAuthenticationMethod"                {              
                $myObject.password = $true 
                # When only the password is set, then MFA is disabled.
                if($myObject.MFAstatus -ne "Enabled")
                {
                    $myObject.MFAstatus = "Disabled"
                }                
           }     
           "#microsoft.graph.phoneAuthenticationMethod"  { 
            $myObject.phone = $true 
            $myObject.MFAstatus = "Enabled"
          }                          
        }
    }

##Collecting objects
$results+= $myObject;

}
# Display the custom objects
$results | Export-csv -path "C:\Users\Administrator\Desktop\MG_MFA_27-10-2023.csv"