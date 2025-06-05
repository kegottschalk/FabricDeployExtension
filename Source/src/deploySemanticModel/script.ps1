[CmdletBinding()]

Param(
  [Parameter(Mandatory=$true)]
  [string]$BaseSourcePath,
  [Parameter(Mandatory=$true)]
  [string]$SemanticModelFolderName,
  [Parameter(Mandatory=$true)]
  [string]$ServicePrincipalAppID,
  [Parameter(Mandatory=$true)]
  [string]$ServicePrincipalSecret,
  [Parameter(Mandatory=$true)]
  [string]$TenantID,
  [Parameter(Mandatory=$true)]
  [string]$DeployEnvironmentName,
  [Parameter(Mandatory=$true)]
  [string]$TargetWorkspaceName,
  [Parameter()]
  [string]$WorkspaceAdminPrincipalID,
  [Parameter()]
  [string]$DBServerName,
  [Parameter()]
  [string]$DatabaseName,
  [Parameter()]
  [Boolean]$DebugMessages
)

if ($DebugMessages) {
    Write-Host "Initial parameters within sub-script:"
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


$path = "$BaseSourcePath"
$semanticModelPath = "$path\$SemanticModelFolderName"
$workingFolder = "$path\.ado"
$appId = "$ServicePrincipalAppID"
$appSecret = "$ServicePrincipalSecret"
$tenantId = "$TenantID"
$environmentName = "$DeployEnvironmentName"
$workspaceName = "$TargetWorkspaceName"
$adminPrincipalId = "$WorkspaceAdminPrincipalID"
$serverName = "$DBServerName"
$databaseName = "$DatabaseName"

New-Item -ItemType Directory -Path "$workingFolder\modules" -ErrorAction SilentlyContinue | Out-Null

Write-Host "##[debug]Downloading FabricPS-PBIP module"
@(
    "https://raw.githubusercontent.com/microsoft/Analysis-Services/master/pbidevmode/fabricps-pbip/FabricPS-PBIP.psm1",
    "https://raw.githubusercontent.com/microsoft/Analysis-Services/master/pbidevmode/fabricps-pbip/FabricPS-PBIP.psd1") |% {

    Invoke-WebRequest -Uri $_ -OutFile "$workingFolder\modules\$(Split-Path $_ -Leaf)"

}

Write-Host "##[debug]Installing Az.Accounts"
if(-not (Get-Module Az.Accounts -ListAvailable)){
    Install-Module Az.Accounts -Scope CurrentUser -Force
}

Write-Host "##[debug]Deploying to environment '$environmentName'"
# Co-Admin, otherwise only the SPN have visibility to the workspace
$workspacePermissions = @{
    "principal" = @{
                        "id" = "$adminPrincipalId"
                        "type" = "user"
                    }
                    "role"= "Admin"
    }

Import-Module "$workingFolder\modules\FabricPS-PBIP" -Force

Write-Host "##[debug]Authentication with SPN"
Set-FabricAuthToken -servicePrincipalId $appId -servicePrincipalSecret $appSecret -tenantId $tenantId -reset

Write-Host "##[debug]Ensure Fabric Workspace exists and set permissions"
$workspaceId = New-FabricWorkspace  -name $workspaceName -skipErrorIfExists
Set-FabricWorkspacePermissions $workspaceId $workspacePermissions

Write-Host "##[debug]Set Semantic Model Parameters"
Set-SemanticModelParameters -path "$semanticModelPath" -parameters @{"ServerName" = "$serverName"; "DatabaseName" = "$databaseName"}

Write-Host "##[debug]Publish PBIP to Fabric"
$importInfo = Import-FabricItems -workspaceId $workspaceId -path $path