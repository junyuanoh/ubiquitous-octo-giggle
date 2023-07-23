# Set input and output file paths - set to the local path of the jumphost
$csvPath = "C:\path\to\input.csv"
$outputPath = "C:\path\to\output.csv"
$computerList = Import-Csv $csvPath

$output = @()
foreach ($computer in $computerList) {
  # Check if computer exists in Active Directory
  $adComputer = Get-ADComputer -Filter "Name -eq '$($computer.Hostname)'"
  $output += [PSCustomObject] @{
    Hostname = $computer.Hostname
    Exists = [bool]$adComputer
  }
  if ($adComputer) {
    Write-Host "Computer $($computer.Hostname) exists."
  } else {
    Write-Host "Computer $($computer.Hostname) does not exist."
  }
}
$output | Export-Csv $outputPath -NoTypeInformation


Get-ADComputer -Filter * -Properties * | Export-Csv "C:\Users\satsaa_ad01_test\Desktop\computer_all_3.csv" -NoTypeInformation