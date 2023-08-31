# Untested - also, u need to be an owner or admin to be do this. 

# Connect to SharePoint Online
Connect-SPOService -Url https://sats1-admin.sharepoint.com/

# Get all site collections
$sites = Get-SPOSite -Limit All

# Create an array to store site information
$siteInfoArray = @()

# Loop through each site and retrieve owner information
foreach ($site in $sites) {
    $siteUrl = $site.Url
    $siteOwners = Get-SPOUser -Site $siteUrl | Where-Object { $_.IsSiteAdmin -eq $true } | Select-Object -ExpandProperty LoginName
    $ownersString = $siteOwners -join ", "
    
    $siteInfo = @{
        SiteUrl = $siteUrl
        Owners = $ownersString
    }
    
    $siteInfoArray += $siteInfo
}

# Convert the array to a CSV format
$csvPath = "\\Mac\Home\Desktop\OutputCSV\SPO_Owners.csv"
$siteInfoArray | Export-Csv -Path $csvPath -NoTypeInformation

# Disconnect from SharePoint Online
Disconnect-SPOService
