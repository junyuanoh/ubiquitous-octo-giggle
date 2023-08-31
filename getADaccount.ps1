# Import ActiveDirectory module
Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = "C:\Users\satsaa_adsupport01\Desktop\SHC_VPN_SAP_user_17-08-2023.csv"
$userList = Import-Csv $csvPath

#use 2 lines below to immediately get attributes of a group
$userList = Get-ADGroupMember -Identity "SG CF All Users Group" | Select SamAccountName
$outputPath = "C:\Users\satsaa_adsupport01\Desktop\SG CF All Users Group_user_23-08-2023.csv"


# Initialize output array
$output = @()
foreach ($user in $userList) {

  $adUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" `
    -Properties *
  if ($adUser) {
    $output += [PSCustomObject] @{
      Enabled           = $adUser.Enabled
      SamAccountName    = $adUser.SamAccountName
      UserPrincipalName = $adUser.UserPrincipalName
      EmailAddress      = $adUser.EmailAddress
      GivenName         = $adUser.GivenName
      SurName           = $adUser.Surname
      DisplayName       = $adUser.DisplayName
      Title             = $adUser.Title
      Department        = $adUser.Department
      Company           = $adUser.Company
      EmployeeNumber    = $adUser.EmployeeNumber
      Description       = $adUser.Description
      whenCreated       = $adUser.whenCreated
      Office            = $adUser.Office
      HomePhone         = $adUser.HomePhone
      Fax               = $adUser.Fax
      IPPhone           = $adUser.ipPhone
      Pager             = $adUser.pager
      Mobile            = $adUser.mobile
      MobilePhone       = $adUser.MobilePhone
      Country           = $adUser.country
    }
  }
}
$output | Export-Csv $outputPath -NoTypeInformation
