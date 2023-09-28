# Mandatory Assignment 01 - IaC IIKG3005

- The purpose of each module
- How to use the Terraform scripts
- Any pre-requisites or dependencies

## Modules

### Network Module

The [Network Module](./kristoju-oppg1/network/main.tf) is used to provision a VNET, Subnet and Network Security Group. The module takes in the following variables: 
> These can also be found in the [variables.tf](./kristoju-oppg1/network/variables.tf) file.

| Variable | Description | Type | Default |
| --- | --- | --- | --- |
| vnet_rg_name | VNET Resource Group Name | string | vnet-rg |
| vnet_rg_location | VNET Resource Group Location | string | westeurope |
| vnet_name | VNET Name | string | vnet |
| vnet_address_space | VNET Address Space | list | | 
| vnet_dns_servers | VNET DNS Servers | list | |
| subnet_name | Subnet Name | string | subnet |
| subnet_address_space | Subnet Address Space | list | |
| nsg_name | Network Security Group Name | string | nsg |
| my_ip | Your IP Address, used for NSG later | string |  |

### Storage Account Module

The [Storage Account Module](./kristoju-oppg1/storageaccount/main.tf) is used to create an Azure Storage Account and a Storage Container. The module takes in the following variables:
> These can also be found in the [variables.tf](./kristoju-oppg1/storageaccount/variables.tf) file.

| Variable | Description | Type | Default |
| --- | --- | --- | --- |
| sa_base_name | Base name of the Storage Account | string | sa |
| sa_rg_name | Storage Account Resource Group Name | string | sa-rg |
| sa_location | Location of the Storage Account | string | westeurope |
| sa_container_name | Name of the Storage Container | string | container |

### Virtual Machine Module

The [Virtual Machine Module](./kristoju-oppg1/virtualmachine/main.tf) is used to provision an Azure Virtual Machine. The module takes in the following variables:
> These can also be found in the [variables.tf](./kristoju-oppg1/virtualmachine/variables.tf) file.

| Variable | Description | Type | Default |
| --- | --- | --- | --- |
| vm_name | Virtual Machine Name | string | vm |
| vm_size | Virtual Machine Size | string | Standard_B2s |
| vm_rg_name | Virtual Machine Resource Group Name | string | vm-rg |
| vm_rg_location | Location of the Virtual Machine Resource Group | string | westeurope |
| vm_nic_name | Virtual Machine NIC Name | string |vm-nic |
| vm_nic_private_ip_address | Virtual Machine NIC Private IP | string | |
| pip_name | Public IP Name | string | vm-pip-name |
| vm_subnet_id | Subnet ID | string | |
| vm_username | Username for the Virtual Machine | string | |
| vm_password | Password for the Virtual Machine | string | |

### Key Vault Module

The [Key Vault Module](./kristoju-oppg1/keyvault/main.tf) is used to provision Azure Key Vault and store secret. The module takes in the following variables:
> These can also be found in the [variables.tf](./kristoju-oppg1/keyvault/variables.tf) file.  

| Variable | Description | Type | Default |
| --- | --- | --- | --- |
| kv_rgname | Key Vault Resource Group Name | string | kv-rg |
| kv_location | location of the Key Vault | string | westeurope |
| kv_base_name | Base name of the Key Vault | string | kv |
| kv_sku_name | SKU of the Key Vault | string | standard |
| sa_access_key | Access key for the Storage Account | string |  |
| sa_base_name | Base name of the Storage Account | string | sa |
| vm_password | Password for the Virtual Machine | string |  |
| vm_username | Username for the Virtual Machine | string |  |

## Dependencies & Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) >= 0.12.0
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) >= 2.0.0
* [Azure Subscription](https://azure.microsoft.com/en-us/free/)
* [Azure Service Principal](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html)

## HOWTO

### Setup

1. Clone the repository
2. Create a `terraform.tfvars` file in the root of the repository and fill in the variables in the [Variables](#variables) section below.
3. Login to Azure using the Azure CLI
   1. Run `az login`
   2. Follow the instructions on the screen
   3. Alternatively, you can login using a Service Principal
      * Run `az login --service-principal -u <service-principal-id> -p <service-principal-password> --tenant <tenant-id>`
4. Run `terraform init` to initialize the project
5. Run `terraform plan` to see what resources will be created
6. Run `terraform apply` to create the resources
7. Run `terraform destroy` to destroy the resources

**Terraform Plan**  
Used to see what resources will be created before running `terraform apply`.  
Can be used in combination with `-out` to save the plan to a file, which can be used later to apply the plan.  
**Example:** `terraform plan -var-file="terraform.tfvars" -out="terraform.tfplan"`  
Using the `-var-file` flag to specify the `terraform.tfvars` file, and the `-out` flag to specify the output file.

Using plan is smart because it will show you what resources will be created, and if there are any errors in the configuration.  
You can also keep track of the plan files in a version control system, and use them to apply the plan later.  
**Example:** `terraform apply "terraform.tfplan"`  

This way, you can make sure you have a plan to fall back to if something goes wrong, and you can also use the plan to apply the configuration to multiple environments.

**Terraform Apply**
Used to apply the configuration to the environment.  
You can specify a plan file to apply, or you can just run `terraform apply` and it will apply the configuration in the current directory.

**Terraform Destroy**  
Used to destroy the resources created by the configuration.  
It is actually an alias for `terraform apply -destroy`, which means that it will apply the configuration, but destroy the resources instead of creating them.    
Using this command will prompt you to confirm the destruction of the resources, unless you use the `-auto-approve` flag.  
**Example:** `terraform destroy -auto-approve`

The main reason for using this command is to make sure that you don't leave any resources running that you don't need.  
This saves you money, as well as making sure nothing collides with the resources you create later.  
It can also be used to destroy the resources created by a plan file.  

### Variables

The following variables are required to run the configuration:
> These can also be found in the [variables.tf](./kristoju-oppg1/variables.tf) file. (Will repeat from the [Modules](#modules) section) 

| Variable | Description | Type | Default | Note | 
| --- | --- | --- | --- | --- |
| company | Company name | string | Company | |
| project | Project name | string | Project | |
| billing code | Billing code | string | Billing | |
| kv_rgname | Key Vault Resource Group Name | string | kv-rg | |
| kv_location | location of the Key Vault | string | westeurope | |
| kv_base_name | Base name of the Key Vault | string | kv | |
| sa_base_name | Base name of the Storage Account | string | sa | |
| sa_rg_name | Storage Account Resource Group Name | string | sa-rg | |
| sa_location | Location of the Storage Account | string | westeurope | |
| sa_container_name | Name of the Storage Container | string | container | |
| vnet_rg_name | VNET Resource Group Name | string | vnet-rg | |
| vnet_rg_location | VNET Resource Group Location | string | westeurope | |
| vnet_name | VNET Name | string | vnet | |
| vnet_address_space | VNET Address Space | list | | Needs to be specified |
| vnet_dns_servers | VNET DNS Servers | list | | Needs to be specified |
| subnet_name | Subnet Name | string | subnet | |
| subnet_address_space | Subnet Address Space | list | | Needs to be specified |
| nsg_name | Network Security Group Name | string | nsg | |
| vm_name | Virtual Machine Name | string | vm | |
| vm_size | Virtual Machine Size | string | Standard_B2s | |
| vm_rg_name | Virtual Machine Resource Group Name | string | vm-rg | |
| vm_rg_location | Location of the Virtual Machine Resource Group | string | westeurope | |
| vm_nic_name | Virtual Machine NIC Name | string |vm-nic | |
| vm_nic_private_ip_address | Virtual Machine NIC Private IP | string | | |
| pip_name | Public IP Name | string | vm-pip-name | |
| vm_subnet_id | Subnet ID | string | | |
| vm_username | Username for the Virtual Machine | string | | Needs to be specified |
| vm_password | Password for the Virtual Machine | string | | Needs to be specified |
| kv_sku_name | SKU of the Key Vault | string | standard | |
| my_ip | Your IP Address, used for NSG later | string | | Needs to be specified, or else an NSG won't work |

The VM public IP address is not specified in the variables, as it is not needed, it will be created automatically and assigned to the VM.  
The VM NIC private IP address is also not specified in the variables, as it is not needed, it will be created automatically and assigned to the VM NIC.  
The VM subnet ID is not specified in the variables, as it is not needed, it will be created automatically and assigned to the VM.  

## Screenshots of Deployment

### Terraform

After finishing the configurations and setup of the modules, and running `terraform init` i ran the following command:   
**terraform plan -var-file="terraform.tfvars" -out="terraform.tfplan"** 

![terraform plan](https://cdn.discordapp.com/attachments/1156933138828759111/1156933309276880896/image.png?ex=6516c59b&is=6515741b&hm=2a7c98f7a9affc9012faef820ea713aa086e7b2c7f0e42a1ef96f63815e3e80a&)

After running the plan, i ran the following command:  
**terraform apply "terraform.tfplan"**

![terraform apply](https://cdn.discordapp.com/attachments/1156933138828759111/1156987762730340403/image.png?ex=6516f852&is=6515a6d2&hm=ac285a380203e3508fc126ec148511c1d7de9863b83d3e73f41afe14b61fe5d0&)

### Azure Portal

After running the apply command, i went to the Azure Portal to check if the resources were created.

**Resource Groups**  
![resource groups](https://cdn.discordapp.com/attachments/1156933138828759111/1156981193254899752/image.png?ex=6516f234&is=6515a0b4&hm=e7a5aa0237223888fd8e1ac502c7a73f79115c976c4e25a276aab975e160a0ad&)

#### Storage Account
Storage Account:  
![storage account](https://cdn.discordapp.com/attachments/1156933138828759111/1156981280370597958/image.png?ex=6516f248&is=6515a0c8&hm=ff82baab06552953ffb48513c741833d2d3f1e5348229c233df953405609ad36&)  

Container:  
![container](https://cdn.discordapp.com/attachments/1156933138828759111/1156981412587634769/image.png?ex=6516f268&is=6515a0e8&hm=ee92698369d8df4fc4f4e22967304f4a956c29b280571e6ed2cca7cc9b6b3b3f&)

#### Network

![vnet-rg](https://cdn.discordapp.com/attachments/1156933138828759111/1156981553096822804/image.png?ex=6516f289&is=6515a109&hm=34489ecca23b3a4828bfb77479ba01c6205d2d7464effd8d40f8910cc4afe2c9&)

VNET:  
![vnet](https://cdn.discordapp.com/attachments/1156933138828759111/1156981771792027708/image.png?ex=6516f2be&is=6515a13e&hm=e332a33711c342519a6f9d1597b006c675c91939f13ae77ef547a226f2d75ecc&)

Subnet:  
![subnet](https://cdn.discordapp.com/attachments/1156933138828759111/1156981771792027708/image.png?ex=6516f2be&is=6515a13e&hm=e332a33711c342519a6f9d1597b006c675c91939f13ae77ef547a226f2d75ecc&)

NSG:  
![nsg](https://cdn.discordapp.com/attachments/1156933138828759111/1156982695017070773/image.png?ex=6516f39a&is=6515a21a&hm=7d3a229603e5a021119cdca3f3421a1a7465f049465494f7c1c7dd0570721e55&)

#### Virtual Machine

![vm-rg](https://cdn.discordapp.com/attachments/1156933138828759111/1156982014373802055/image.png?ex=6516f2f7&is=6515a177&hm=835d61b65af27e6af37d1aecbd1dfd285f03a8216235ee9290b71957e4ff45f8&)

VM:  
![vm](https://cdn.discordapp.com/attachments/1156933138828759111/1156982286621888673/image.png?ex=6516f338&is=6515a1b8&hm=6c7253102e27d478fc2295ef0d0b217f7c58034a412ce76aed35222014e3e541&)

VM Details:  
![vm-details](https://cdn.discordapp.com/attachments/1156933138828759111/1156982331345739804/image.png?ex=6516f343&is=6515a1c3&hm=1eaa442b96796009009d5e1312c94fd97ce3734d1affa74077d71bb1bff13b6f&)

VM NIC:  
![vm-nic](https://cdn.discordapp.com/attachments/1156933138828759111/1156982415563169792/image.png?ex=6516f357&is=6515a1d7&hm=1cea2c7687daef291021a23ed0805de6882c8aa813507e2288c304da15b0416e&)

Public IP:  
![pip](https://cdn.discordapp.com/attachments/1156933138828759111/1156982070925606962/image.png?ex=6516f305&is=6515a185&hm=cf52820364ba30f6656613c6880688d376c22b4cc6f226637396a1e9e7691fa8&)

#### Key Vault

![kv-nsg](https://cdn.discordapp.com/attachments/1156933138828759111/1156982762738290879/image.png?ex=6516f3aa&is=6515a22a&hm=718dbb1f151ebe502b8b1fea6f37d89e066938da383083abcecf04cc653a25aa&)

Keyvault Secrets:  
![kv-secrets](https://cdn.discordapp.com/attachments/1156933138828759111/1156983561019207761/image.png?ex=6516f468&is=6515a2e8&hm=3a7ffcf0ee3113877c700363ae5be72182e28cf2ea393505083d1cc905b7da59&)

> **Note**: To be able to view these secrets in the Azure Portal, you need to have access to the Key Vault.  
> By default we only allowed access for our application, so we need to add access for our user account to see it.   
> This can be done by going to the Key Vault, and then going to **Access Policies** and adding your user account with the **Get**, and **List** permission.  
> You will not be able to see the values directly.  

### Terraform

After finishing with the resources, i ran the following command:  
**terraform destroy**

![terraform destroy](https://cdn.discordapp.com/attachments/1156933138828759111/1156985016056819883/image.png?ex=6516f5c3&is=6515a443&hm=772f9d0019d0c2a2cf676441b2aec5145fd06f7e75e890c87257940a3e38f6af&)

After running the destroy command, i went to the Azure Portal to check if the resources were deleted.

![azure portal](https://cdn.discordapp.com/attachments/1156933138828759111/1156985275940098048/image.png?ex=6516f601&is=6515a481&hm=894c55c69ef27d68619a4f24e48ebdfed2e9f6dd1613d99aa561d61c0e28d2ac&)

And then we are done. 

> **Note**: There were some issues with having the vm_password as a variable, so to set this up i put it directly in the [main.tf](./virtualmachine/main.tf) file of the virtualmachine module.   
> I am not sure why this did not work, as it should have, perhaps it will work for you. 

Error message I got: 
```
"admin_password" has to fulfill 3 out of these 4 conditions: Has lower characters, Has upper characters, Has a digit, Has a special character other than "_", fullfiled only 2 conditions
```

Password used in the [.tfvars](./terraform.tfvars) file: "SPF535aLf&6!Ro^^Z7#W^j#JEW4ye6"