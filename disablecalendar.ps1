Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
$calen = Read-Host "Enter calendar UPN"
Set-CalendarProcessing -Identity $calen -AllBookInPolicy $False #True 
Get-CalendarProcessing -Identity $calen | Format-List *Policy*

Set-CalendarProcessing -Identity $calen  -BookInPolicy $group -AllBookInPolicy $false
