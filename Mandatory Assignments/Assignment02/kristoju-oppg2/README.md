<!-- A README.md file explaining:
* How to use the Terraform scripts
* Any pre-requisites or dependencies
* A terraform.tfvars file containing values for all the input variables.
* Output screenshots showing the successful workflow and the deployed infrastructure. Remember to destroy resources when you are done. -->

# Mandatory Assignment 02 - IaC IIKG3005

## Prerequisites

### Terraform

First, you need to create the backend storage account and container in Azure. This can be done by running the following commands:

```bash
az login
az account set --subscription <subscription_id>
az group create --resource-group <resource_group_name> --location <location>
az storage account create --name <storage_account_name> --resource-group <resource_group_name> --location <location> --sku Standard_LRS
az storage container create --name <container_name> --account-name <storage_account_name>
```

Then, you need to create a service principal with the following command:

```bash
az ad sp create-for-rbac --name <service_principal_name> --role contributor --scopes /subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Storage/storageAccounts/<storage_account_name>
```

It's also benificial to create environment variables for the service principal credentials, the different values can be gotten when creating the service principal:

```bash
$env:ARM_CLIENT_ID="<client_id>"
$env:ARM_CLIENT_SECRET="<client_secret>"
$env:ARM_CLIENT_TENANT_ID="<tenant_id>"
$env:ARM_SUBSCRIPTION_ID="<subscription_id>"
```

### GitHub

You also need to create GitHub repository secrets for the service principal credentials, the following have to be created.  
Go to the repository, then Settings -> Secrets and Variables -> Actions -> New repository secret.

```bash
AZURE_CLIENT_ID
AZURE_CLIENT_SECRET
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID

AZURE_CREDENTIALS

{
  "clientId": "",
  "clientSecret": "",
  "subscriptionId": "",
  "tenantId": "",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

### Terraform Workspaces

The following workspaces have to be created:

```bash
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
```

### Terraform Variables

The terraform.tfvars file has to be filled out correctly, for the delivery this will be provided in the zip file.  
Note that the backend storage account and container has to be created before running the terraform scripts.

## HOWTO

Below is a guide on how to use the Terraform scripts, and how it is set up with GitHub Actions.

### GitHub

This repository is set up with GitHub Actions, and the workflow can be found in the .github/workflows folder.  
The following workflows are set up:

* **devstageprodweb.yml** - This workflow is triggered when a pull request is created, and will run the terraform init and plan command for each terraform workspace.
  * It will then check the commit message for the following keywords:
    * **[apply]** - This will run the terraform apply command, and deploy the infrastructure.
    * **[destroy]** - This will cancel the terraform destroy command, and destroy the infrastructure.
  * Anything else will not cause the workflow to apply the infrastructure, but only validate the terraform scripts.
  * The **dev** and **stage** workspace do not have any protection rules, so the workflow will run the terraform apply command for these workspaces.
  * The **prod** workspace is protected, so the workflow will not run the terraform apply command for this workspace until it is manually approved.

* **validate.yml** - This workflow is triggered when a push is done to a different branch than the **main** branch, and all it does is validate the terraform configuration with the `terraform validate` command. 
  * After it has been validated, it will create a pull request to the **main** branch, and wait for it to be merged.



In this repository I have protected my main branch, so any changes must be done through pull requests.  
This is done to ensure that the code is valid, and that the pull request can be merged.  

### Terraform

The Terraform scripts are set up with the following structure:

```bash
.
├───.terraform
├───keyvault
│   ├─main.tf
│   ├─outputs.tf
│   └─variables.tf
├───network
│   ├─main.tf
│   ├─outputs.tf
│   └─variables.tf
├───storageaccount
│   ├─main.tf
│   ├─outputs.tf
│   └─variables.tf
├───virtualmachine
│   ├─main.tf
│   ├─outputs.tf
│   └─variables.tf
├─main.tf
├─locals.tf
├─outputs.tf
├─terraform.tfvars
├─providers.tf
└─variables.tf
```

## Showcase of Successful Workflow