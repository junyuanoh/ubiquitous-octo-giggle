#As application owner who has client secret:
New-MgSitePermission -SiteId $siteId -BodyParameter $params

$tenantId="5af395c7-bcfc-43ac-98fa-a57dd56b8796"
$aadClientId = "114f4682-5370-456e-931d-bae14cf0444e"
$aadClientSecret = "N4T8Q~n7yH0ez3IQHtoyhdhOJb5T86h4BjarOb4E"

$scopes =  "https://graph.microsoft.com/.default"
$loginURL = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{grant_type="client_credentials";client_id=$aadClientId;client_secret=$aadClientSecret;scope=$scopes}

$Token = Invoke-RestMethod -Method Post -Uri $loginURL -Body $body
$Token.access_token  #expires after one hour
$headerParams  = @{'Authorization'="$($Token.token_type) $($Token.access_token)"}
$headerParams

#Graph API call to get site
Invoke-WebRequest -Method Get -Headers $headerParams -Uri "https://graph.microsoft.com/v1.0/sites/sats1.sharepoint.com:/sites/CKB_UAT"


####

#As SharePoint admin:
Connect-MgGraph -scopes Sites.FullControl.All
Import-Module Microsoft.Graph.Sites
$siteId = "ffe7b28d-fbbc-4fdf-975f-b6bad90b9a0f"
$sitePermissions = Get-MgSitePermission -SiteId $siteId
$sitePermissions.GrantedToIdentities | Select -ExpandProperty Application | FL