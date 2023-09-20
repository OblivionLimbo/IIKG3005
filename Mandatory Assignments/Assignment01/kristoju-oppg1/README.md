# Mandatory Assignment 01 - IaC IIKG3005

- The purpose of each module
- How to use the Terraform scripts
- Any pre-requisites or dependencies

## Modules

### Network Module

The [Network Module](./kristoju-oppg1/network/main.tf) is used to provision a VNET, Subnet and Network Security Group. The module takes in the following variables:

### Storage Account Module

The [Storage Account Module](./kristoju-oppg1/storageaccount/main.tf) is used to create an Azure Storage Account and a Storage Container. The module takes in the following variables:

### Virtual Machine Module

The [Virtual Machine Module](./kristoju-oppg1/virtualmachine/main.tf) is used to provision an Azure Virtual Machine. The module takes in the following variables:

### Key Vault Module

The [Key Vault Module](./kristoju-oppg1/keyvault/main.tf) is used to provision Azure Key Vault and store secret. The module takes in the following variables:

## Dependencies & Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) >= 0.12.0
* [AWS CLI](https://aws.amazon.com/cli/) >= 1.16.0

### Secrets

The following secrets are required to run the project:  
AZURE_CLIENT_ID  
- Can be found in the Azure portal under "Microsoft Entra ID" -> "App registrations" -> "Your app" -> "Application (client) ID"  

AZURE_CLIENT_SECRET  
- Can be found in the Azure portal under "Microsoft Entra ID" -> "App registrations" -> "Your app" -> "Certificates & secrets" -> "Client secrets" 
- Copy the value and save it somewhere safe. It will not be shown again. 
- If you cannot see it or have not saved it, create a new secret and copy it's value.  

AZURE_SUBSCRIPTION_ID  
- Can be found in the Azure portal under "Subscriptions" -> "Your subscription" -> "Subscription ID"  

AZURE_TENANT_ID  
- Can be found in the Azure portal under "Microsoft Entra ID" -> "Overview" -> "Tenant ID"  

AZURE_CREDENTIALS
```
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
Fill in this with the correct values and add it as a new secret. 

## HOWTO