# Import ActiveDirectory module
Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = Read-Host "Enter path to output .csv" 
$userList = Import-Csv $csvPath

# Initialize output array
$output = @()
foreach ($user in $userList) {

  $adUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" `
    -Properties Enabled, UserPrincipalName, SamAccountName, Description
  if ($adUser) {
    $output += [PSCustomObject] @{
      Enabled = $adUser.Enabled
      UserPrincipalName = $adUser.UserPrincipalName
      SamAccountName = $adUser.SamAccountName
      Description = $adUser.Description
    }
  }
}
$output | Export-Csv $outputPath -NoTypeInformation
