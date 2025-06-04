# Fabric Deploy Extension
Azure DevOps Extension with DevOps Pipeline Tasks for deploying MS Fabric items. Tasks assume Power BI / Fabric items are created using the Power BI Project file format (.pbip).

For more information on .pbip format, please see: https://learn.microsoft.com/en-us/power-bi/developer/projects/projects-overview

This code is intended to be built and packaged into a DevOps Marketplace Extension: https://marketplace.visualstudio.com/azuredevops. I have not formally released the Marketplace Extension publicly, as I don't think its ready for prime-time yet, but I'd be happy to share the extension with your organization.

This extension makes heavy use of Rui Romano's FabricPS-PBIP code: https://github.com/microsoft/Analysis-Services/tree/master/pbidevmode/fabricps-pbip - Thanks Rui!

I have simply created a wrapper of sorts around Rui's PowerShell scripts to make the YML code within the DevOps Pipeline more straightforward.

The Extension current has two Tasks: 

- **Fabric Report (pbip) Deploy** - Deploys a Power BI Report stored in .pbip format to the Power BI service
- **Fabric Semantic Model (pbip) Deploy** - Deploys a Power BI Semantic Model stored in .pbip format to the Power BI service. For now, assumes a connection to a SQL Server and supports dynamically changing Server / Database Name

