# Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

# Variables for Processing
$UserAccount = "i:0#.f|membership|Salaudeen@crescent.com"

# Load CSV File
$CSVPath = "C:\Path\To\SiteList.csv"
$SiteList = Import-Csv -Path $CSVPath

# Setup Credentials to connect
$Cred = Get-Credential
$Cred = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName, $Cred.Password)

# Loop through each site URL in the CSV
foreach ($SiteInfo in $SiteList) {
    $SiteURL = $SiteInfo.SiteURL
    
    # Setup the context
    $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
    $Ctx.Credentials = $Cred
    
    # Ensure the user exists
    $User = $Ctx.Web.EnsureUser($UserAccount)
    
    # Add the user as a Site Collection Administrator
    $User.IsSiteAdmin = $True
    $User.Update()
    $Ctx.ExecuteQuery()

    Write-Host "Added $UserAccount as a Site Collection Administrator for $SiteURL"
}
