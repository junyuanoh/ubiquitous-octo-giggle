# Import ActiveDirectory module
Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = Read-Host "Enter path to output .csv" 
$userList = Import-Csv $csvPath

# Initialize output array
$output = @()
foreach ($user in $userList) {

  $adUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" `
    -Properties *
  if ($adUser) {
    $output += [PSCustomObject] @{
      Enabled = $adUser.Enabled
      UserPrincipalName = $adUser.UserPrincipalName
      SamAccountName = $adUser.SamAccountName
      Description = $adUser.Description
      DisplayName = $adUser.DisplayName
      FirstName = $adUser.givenName
      LastName = $aduser.surname
      FullName = $aduser.name
    }
  }
}
$output | Export-Csv $outputPath -NoTypeInformation
