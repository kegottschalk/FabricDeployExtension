[CmdletBinding()]

param()

$BaseSourcePath = Get-VstsInput -Name 'BaseSourcePath'
$SemanticModelFolderName = Get-VstsInput -Name 'SemanticModelFolderName'
$ServicePrincipalAppID = Get-VstsInput -Name 'ServicePrincipalAppID'
$ServicePrincipalSecret = Get-VstsInput -Name 'ServicePrincipalSecret'
$TenantID = Get-VstsInput -Name 'TenantID'
$DeployEnvironmentName = Get-VstsInput -Name 'DeployEnvironmentName'
$TargetWorkspaceName = Get-VstsInput -Name 'TargetWorkspaceName'
$WorkspaceAdminPrincipalID = Get-VstsInput -Name 'WorkspaceAdminPrincipalID'
$DBServerName = Get-VstsInput -Name 'DBServerName'
$DatabaseName = Get-VstsInput -Name 'DatabaseName'
$Debug = Get-VstsInput -Name 'Debug'


if ($Debug) {
    Write-Host "Initial parameters:"
    Write-Host "BaseSourcePath = $BaseSourcePath"
    Write-Host "SemanticModelFolderName = $SemanticModelFolderName"
    Write-Host "ServicePrincipalAppID = $ServicePrincipalAppID"
    Write-Host "ServicePrincipalSecret = $ServicePrincipalSecret"
    Write-Host "TenantID = $TenantID"
    Write-Host "DeployEnvironmentName = $DeployEnvironmentName"
    Write-Host "TargetWorkspaceName = $TargetWorkspaceName"
    Write-Host "WorkspaceAdminPrincipalID = $WorkspaceAdminPrincipalID"
    Write-Host "DBServerName = $DBServerName"
    Write-Host "DatabaseName = $DatabaseName"
}

#Need to call "pwsh" since PowerShell 7.0+ is required for the PBI deployment modules
Write-Host "##Calling PowerShell 7.0 script"
& pwsh script.ps1 -BaseSourcePath $BaseSourcePath -SemanticModelFolderName $SemanticModelFolderName -ServicePrincipalAppID $ServicePrincipalAppID -ServicePrincipalSecret $ServicePrincipalSecret -TenantID $TenantID -DeployEnvironmentName $DeployEnvironmentName -TargetWorkspaceName $TargetWorkspaceName -WorkspaceAdminPrincipalID $WorkspaceAdminPrincipalID -DBServerName $DBServerName -DatabaseName $DatabaseName -DebugMessages:$Debug