#Connect to Exchange Online
Connect-ExchangeOnline -ShowBanner:$False
 
#Set Date Filters - past 24 hours!
$StartDate = (Get-Date).AddDays(-30)
$EndDate = Get-Date
 
#Search Unified Log
$SharePointLog = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType SharePointFileOperation
$AuditLogResults = $SharePointLog.AuditData | ConvertFrom-Json | Select CreationTime,UserId,Operation, ObjectID,SiteUrl,SourceFileName,ClientIP
 
#Export Audit log results to CSV
$AuditLogResults
$AuditLogResults | Export-csv -Path "C:\Temp\AuditLog_all01.csv" -NoTypeInformation


#Filter Audit log to Find specific operations

###

# Get the first day and the last day of the current month
$date = Get-Date
$year = $date.Year
$month = $date.Month
$startOfMonth = Get-Date -Year $year -Month $month -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
$endOfMonth = ($startOfMonth).AddMonths(1).AddTicks(-1)
#Get the current month name
$monthName = (Get-Culture).DateTimeFormat.GetMonthName((Get-Date).Month)

####
Connect-ExchangeOnline
#Search for the last 30 days. Also accepts timestamp format in MM/DD/YYYY
$StartDate = (Get-Date).AddDays(-30)
$EndDate = Get-Date

###

#$SiteURLs = @("https://servbridge.sharepoint.com/*")
$SiteURLs = @("https://sats1.sharepoint.com/*")
#$SiteURLs = @("https://zqh7j.sharepoint.com/*")
$CSVFile = "C:\Temp\NewNewAuditLog_specific04.csv"
#$FileAccessOperations = @('PageViewed', 'PageViewedExtended','FileAccessed', 'FileAccessedExtended','FileDeleted')
$FileAccessLog = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -ResultSize 5000 -ObjectIds $SiteURLs
$FileAccessLog.AuditData | ConvertFrom-Json | Select CreationTime,UserId,Operation, ObjectID ,SiteUrl,SourceFileName,ClientIP  | Export-csv $CSVFile -NoTypeInformation -Force

#Read more: https://www.sharepointdiary.com/2019/09/sharepoint-online-search-audit-logs-in-security-compliance-center.html#ixzz8EIajVhOp

##finished

####
Connect-ExchangeOnline

#Search for the last 30 days. Also accepts timestamp format in MM/DD/YYYY
$StartDate = (Get-Date).AddDays(-30)
$EndDate = Get-Date

#Either the entire SharePoint is searched, or can be scoped down to https://servbridge.sharepoint.com/sites/yoursitename/*
$SiteURLs = @("https://servbridge.sharepoint.com/*")

#Location of csv file to be saved
$CSVFile = "C:\Temp\NewNewAuditLog_specific04.csv"

#Main search cmdlet
$FileAccessLog = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -ResultSize 5000 -ObjectIds $SiteURLs

#Export of data. Attributes adjacent to Select can be replaced with * for all attributes to be selected
$FileAccessLog.AuditData | ConvertFrom-Json | Select CreationTime,UserId,Operation, ObjectID ,SiteUrl,SourceFileName,ClientIP  | Export-csv $CSVFile -NoTypeInformation -Force

#Read more: https://www.sharepointdiary.com/2019/09/sharepoint-online-search-audit-logs-in-security-compliance-center.html#ixzz8EIajVhOp



