Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = Read-Host "Enter path to output .csv" 
$userList = Import-Csv $csvPath

$output = @()
foreach ($user in $userList) {
  $adUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" -Properties EmployeeNumber
  if ($adUser) {
    Set-ADUser $adUser -EmployeeNumber $user.EmployeeNumber
    $adUser = Get-ADUser -Identity $adUser.DistinguishedName -Properties EmployeeNumber
    $output += [PSCustomObject] @{
      SamAccountName = $adUser.SamAccountName
      EmployeeNumber = $adUser.EmployeeNumber
    }
    Write-Host "Updated EmployeeNumber for $($adUser.SamAccountName)"
  }
  else {
    Write-Host "User $($user.SamAccountName) not found"
  }
}
$output | Export-Csv $outputPath -NoTypeInformation
