#https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.sites/new-mgsitepermission?view=graph-powershell-1.0
#https://learn.microsoft.com/en-us/graph/permissions-reference#sites-permissions
#https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/develop-applications-that-use-sites-selected-permissions-for-spo/ba-p/3790476

#https://sats1.sharepoint.com/sites/CKB_UAT/_api/site/id for site ID
#https://sats1.sharepoint.com/sites/CKB_UAT/_api/web/id for web ID

Connect-MgGraph -scopes Sites.FullControl.All
Import-Module Microsoft.Graph.Sites

$siteId = "065da60c-41c7-404c-a690-4863e5469efc"
$params = @{
	roles = @(
		"write"
	)
	grantedToIdentities = @(
		@{
			application = @{
				id = "114f4682-5370-456e-931d-bae14cf0444e"
				displayName = "Culinary Knowledge Base"
			}
		}
	)
}

New-MgSitePermission -SiteId $siteId -BodyParameter $params
