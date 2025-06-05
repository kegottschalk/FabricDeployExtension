# Fabric Deploy Extension
Azure DevOps Extension with DevOps Pipeline Tasks for deploying MS Fabric items. Tasks assume Power BI / Fabric items are created using the Power BI Project file format (.pbip).

For more information on .pbip format, please see: https://learn.microsoft.com/en-us/power-bi/developer/projects/projects-overview

This code is intended to be built and packaged into a DevOps Marketplace Extension: https://marketplace.visualstudio.com/azuredevops. I have not formally released the Marketplace Extension publicly, as I don't think its ready for prime-time yet, but I'd be happy to share the extension with your organization if you want to help me test / enhance it!

This extension makes heavy use of Rui Romano's FabricPS-PBIP code: https://github.com/microsoft/Analysis-Services/tree/master/pbidevmode/fabricps-pbip - Thanks Rui!

I have simply created a wrapper of sorts around Rui's PowerShell scripts to make the .yml code within the DevOps Pipeline more straightforward.

The Extension current has two Tasks: 

- **Fabric Report (pbip) Deploy** - Deploys a Power BI Report stored in .pbip format to the Power BI service. Supports dynamically setting the Semantic Model.
- **Fabric Semantic Model (pbip) Deploy** - Deploys a Power BI Semantic Model stored in .pbip format to the Power BI service. For now, assumes a connection to a SQL Server and supports dynamically changing Server / Database Name

## Fabric Report (pbip) Deploy
The Fabric Report (pbip) Deploy Task will deploy a Power BI Report stored in .pbip format to the Power BI Service. Task will create the target Workspace if it does not exist, optionally assign a Workspace Admin to the workspace, find the ID of the named Semantic Model, assign that Semantic Model ID to the Report, then finally deploy the report. The Task is built on the assumption that you have separated your Semantic Model from your Report and that the needed Semantic Model has already been deployed to the Power BI Service.

The Task takes the following Parameters:
- **Base Source Path** - Root folder where the Report .pbip file is located.
- **Report Folder Name** - Name of the <ReportName>.Report folder where the Report definition is located
- **Service Principal AppID** - Service Principal AppID. Used to obtain an Authentication Token. The Service Principal needs Workspace.ReadWrite.All API Permission on the Power BI Service.
- **Service Principal Secret** - Service Principal Secret. Used to obtain an Authentication Token
- **Tenant ID** - Azure Tenant ID. Used to obtain an Authentication Token.
- **Deploy Environment Name** - Name of the environment to deploy to, used for debugging/logging only, this is not a named DevOps Environment.
- **Target Workspace Name** - Name of the Power BI Workspace to deploy to
- **Workspace Admin Principal ID** - Entra Object ID to assign as a Workspace Admin to the Target Workspace.
- **Semantic Model for Report** - The Power BI Display Name of the Semantic Model to assign to this Report.
- **Debug Messages** - Show debug messages during task execution.

## Fabric Semantic Model (pbip) Deploy
The Fabric Semantic Model (pbip) Deploy Task will deploy a Power BI Semantic Model stored in .pbip format to the Power BI Service. Task will create the target Workspace if it does not exist, optionally assign a Workspace Admin to the workspace, optionally assign values to the ServerName and DatabaseName parameters for a dynamic connection, then finally deploy the model. The Task is built on the assumption that you have separated your Semantic Model from your Report and also the Semantic Model is connecting to a SQL Server if you are planning to use the ServerName/DatabaseName parameters.

The Task takes the following Parameters:
- **Base Source Path** - Root folder where the Semantic Model .pbip file is located.
- **Semantic Model Folder Name** - Name of the <SemanticModelName>.SemanticModel folder where the Semantic Model definition is located
- **Service Principal AppID** - Service Principal AppID. Used to obtain an Authentication Token. The Service Principal needs Workspace.ReadWrite.All API Permission on the Power BI Service.
- **Service Principal Secret** - Service Principal Secret. Used to obtain an Authentication Token
- **Tenant ID** - Azure Tenant ID. Used to obtain an Authentication Token.
- **Deploy Environment Name** - Name of the environment to deploy to, used for debugging/logging only, this is not a named DevOps Environment.
- **Target Workspace Name** - Name of the Power BI Workspace to deploy to
- **Workspace Admin Principal ID** - Entra Object ID to assign as a Workspace Admin to the Target Workspace.
- **DB Server Name** - Server Name to dynamically assign to this Semantic Model. Assumes the Model has a Parameter named 'ServerName'
- **Database Name** - Database Name to dynamically assign to this Semantic Model. Assumes the Model has a Parameter named 'DatabaseName'
- **Debug Messages** - Show debug messages during task execution.

# Contribute
If you would like to offer improvements or suggestions, please create a pull request.
