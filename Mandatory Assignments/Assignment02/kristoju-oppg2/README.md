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
