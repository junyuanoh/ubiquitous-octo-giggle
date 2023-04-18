Import-Module ActiveDirectory

# Import users from CSV
Import-Csv -path "C:\Users\satsaa_ad12\Desktop\company_leftover.csv" | ForEach-Object {
$samAccountName = $_."samAccountName"
$company = $_."company"

if (Get-ADUser -F {SamAccountName -eq $samAccountName}){
    Set-AdUser -Identity $samAccountName -Company $company
    Get-ADUser $samAccountName -Properties UserPrincipalName,Company | Select  UserPrincipalName,Company
    }
else{
    Write-Host $samAccountName " does not exist.Please check user details" "`n `n `n"   
    }
}