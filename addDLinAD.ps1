Import-Module ActiveDirectory

$csvloc = Read-Host "Enter path to .csv" 
# Import users from CSV
Import-Csv $csvloc | ForEach-Object {
$samAccountName = $_."samAccountName"

if (Get-ADUser -F {SamAccountName -eq $samAccountName} ){

Add-ADGroupMember -Identity "SP PT Staff List" -Members $samAccountName
Write-Host "Added $samAccountName into SP PT Staff List"
    }
else{
Write-Host $samAccountName " does not exist.Please check user details" "`n `n `n"   
    }
}
