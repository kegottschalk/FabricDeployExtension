[CmdletBinding()]

param()

$BaseSourcePath = Get-VstsInput -Name 'BaseSourcePath'
$ReportFolderName = Get-VstsInput -Name 'ReportFolderName'
$ServicePrincipalAppID = Get-VstsInput -Name 'ServicePrincipalAppID'
$ServicePrincipalSecret = Get-VstsInput -Name 'ServicePrincipalSecret'
$TenantID = Get-VstsInput -Name 'TenantID'
$DeployEnvironmentName = Get-VstsInput -Name 'DeployEnvironmentName'
$TargetWorkspaceName = Get-VstsInput -Name 'TargetWorkspaceName'
$WorkspaceAdminPrincipalID = Get-VstsInput -Name 'WorkspaceAdminPrincipalID'
$SemanticModelForReport = Get-VstsInput -Name 'SemanticModelForReport'
$Debug = Get-VstsInput -Name 'Debug'


if ($Debug) {
    Write-Host "Initial parameters:"
    Write-Host "BaseSourcePath = $BaseSourcePath"
    Write-Host "ReportFolderName = $ReportFolderName"
    Write-Host "ServicePrincipalAppID = $ServicePrincipalAppID"
    Write-Host "ServicePrincipalSecret = $ServicePrincipalSecret"
    Write-Host "TenantID = $TenantID"
    Write-Host "DeployEnvironmentName = $DeployEnvironmentName"
    Write-Host "TargetWorkspaceName = $TargetWorkspaceName"
    Write-Host "WorkspaceAdminPrincipalID = $WorkspaceAdminPrincipalID"
    Write-Host "SemanticModelForReport = $SemanticModelForReport"
}

#Need to call "pwsh" since PowerShell 7.0+ is required for the PBI deployment modules
Write-Host "##Calling PowerShell 7.0 script"
& pwsh script.ps1 -BaseSourcePath $BaseSourcePath -ReportFolderName $ReportFolderName -ServicePrincipalAppID $ServicePrincipalAppID -ServicePrincipalSecret $ServicePrincipalSecret -TenantID $TenantID -DeployEnvironmentName $DeployEnvironmentName -TargetWorkspaceName $TargetWorkspaceName -WorkspaceAdminPrincipalID $WorkspaceAdminPrincipalID -SemanticModelForReport $SemanticModelForReport -DebugMessages:$Debug