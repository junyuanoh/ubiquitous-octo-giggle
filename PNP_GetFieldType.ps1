#To get specific site fields, scope down to site URL. To do source site, Connect-PnPOnline servbridge-admin.sharepoint.com -Interactive
connect-pnponline servbridge.sharepoint.com/sites/SingtelProject-SATS -interactive

#With site scoped down, run get-pnpfield and export results
Get-PnPField -List "Documents" |  Export-Csv -Path "C:\temp\documentfields.csv" -Force -NoTypeInformation