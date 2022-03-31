Write-Host "Setting execution policy to remote signed"
Write-Host ""
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Write-Host "Completed."