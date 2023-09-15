#NOTE!! Install SharePoint Online Client Components SDK first - https://www.microsoft.com/en-us/download/details.aspx?id=42038
#Pick 'sharepointclientcomponents_16-6906-1200_x64-en-us.msi'

#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

#Alternate to loading CSOM Assemblies if above does not work
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SharePoint.Client”)
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SharePoint.Client.Runtime”)
      
#Config Parameters
$SiteURL= "https://servbridge.sharepoint.com/sites/SingtelProject-SATS"
$ListName = "Documents"
$CSVPath = "C:\Temp\SingtelProject-SATS_DocumentLibraryRpt_3.csv"
$BatchSize = 500
  
#Get Credentials to connect
$Cred = Get-Credential
  
Try {
    #Setup the context
    $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
    $Ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName,$Cred.Password)
      
    #Get the Document Library
    $List =$Ctx.Web.Lists.GetByTitle($ListName)
      
    #Define CAML Query to Get List Items in batches
    $Query = New-Object Microsoft.SharePoint.Client.CamlQuery
    $Query.ViewXml ="
    <View Scope='RecursiveAll'>
        <Query>
            <OrderBy><FieldRef Name='ID' Ascending='TRUE'/></OrderBy>
        </Query>
        <RowLimit Paged='TRUE'>$BatchSize</RowLimit>
    </View>"
 
    $DataCollection = @()
    Do
    {
        #get List items
        $ListItems = $List.GetItems($Query) 
        $Ctx.Load($ListItems)
        $Ctx.ExecuteQuery() 
 
        #Iterate through each item in the document library
        ForEach($ListItem in $ListItems)
        {
            #Collect data        
            $Data = New-Object PSObject -Property ([Ordered] @{
                LastModified = $ListItem.FieldValues.Modified
                LastModifiedTimestamp = $ListItem.FieldValues.SMLastModifiedDate
                LastModifiedBy = $ListItem.FieldValues.Editor.Email
                Location = $ListItem.FieldValues.FileDirRef
                ContentType = $ListItem.FieldValues.File_x0020_Type
                FileSize = $ListItem.FieldValues.File_x0020_Size
                CheckOut = $ListItem.FieldValues.IsCheckedoutToLocal
                VersionNumber = $ListItem.FieldValues.ContentVersion
                NeverCheckedIn = $ListItem.FieldValues._CheckinComment
                CreatedDate = $ListItem.FieldValues.Created
                CreatedDateTimestamp = $ListItem.FieldValues.Created_x0020_Date
                CreatedBy = $ListItem.FieldValues.Author.Email
            })
            $DataCollection += $Data
        }
        $Query.ListItemCollectionPosition = $ListItems.ListItemCollectionPosition
    }While($Query.ListItemCollectionPosition -ne $null)
 
    #Export Documents data to CSV
    $DataCollection | Export-Csv -Path $CSVPath -Force -NoTypeInformation
    Write-host -f Green "Document Library Inventory Exported to CSV!"
}
Catch {
    write-host -f Red "Error:" $_.Exception.Message
}


