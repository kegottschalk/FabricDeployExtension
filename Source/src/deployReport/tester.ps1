Write-Host "##Calling PowerShell 7.0 script"
$BaseSourcePath = 'BSP1'
$DebugMessages = $true
& pwsh script.ps1 -BaseSourcePath $BaseSourcePath -ReportFolderName 'RFN' -ServicePrincipalAppID 'SPAID' -ServicePrincipalSecret 'SPSec' -TenantID 'TenID' -DeployEnvironmentName 'DEN' -TargetWorkspaceName 'TWN' -WorkspaceAdminPrincipalID 'WAPID' -SemanticModelForReport 'SMFR' -DebugMessages:$DebugMessages

