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
az ad sp create-for-rbac --name <service_principal_name> --role contributor --scopes /subscriptions/<subscription_id>/resourceGroups/<resource_group_name>
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

* **devstageprodweb.yml** - This workflow is triggered when a push is done, or on a pull request, and will run the terraform init and plan command for each terraform workspace.
  * It will then check the commit message for the following keywords:
    * **[apply dev]** - This will run the terraform apply command on dev, and deploy the dev infrastructure.
    * **[destroy dev]** - This will cancel the terraform destroy command on dev, and destroy the dev infrastructure.
  * The same goes for **stage** and **prod**.
    * **[apply all]** - This will run the terraform apply command on all workspaces, and deploy the infrastructure for all workspaces.
    * **[destroy all]** - This will cancel the terraform destroy command on all workspaces, and destroy the infrastructure for all workspaces.
  * Anything else will not cause the workflow to apply the infrastructure, but only validate the terraform scripts.
  * The **dev** and **stage** workspace do not have any protection rules, so the workflow will run the terraform apply command for these workspaces.
  * The **prod** workspace is protected, so the workflow will not run the terraform apply command for this workspace until it is manually approved.

* **validate.yml** - This workflow is triggered when a push is done to a different branch than the **main** branch, and all it does is validate the terraform configuration with the `terraform validate` command. 
  * After it has been validated, you can create a pull request to the **main** branch, and the **devstageprod.yml** workflow will run.
* **tfsec.yml** - This workflow is triggered when **validate.yml** is finished, and will run the `tfsec` command to check for security issues in the terraform scripts.
  * This currently fails as there are some security issues in the terraform scripts, but I have not fixed them. 
* **tflint.yml** - This workflow is triggered when **validate.yml** is finished, and will run the `tflint` command to check for errors in the terraform scripts.

In the future I would like to set up a workflow that runs the terraform validate command when a pull request is created, and then run the terraform apply command when the pull request is merged.
But I have not been able to figure out how to do this yet, and did not have time to do it for this assignment.

In this repository I have protected my main branch, so any changes must be done through pull requests, unless you force it to main.  
This is done to ensure that the code is valid, and that the pull request can be merged.  

### Terraform

The Terraform scripts are set up with the following structure:

```bash
./openterra
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

When everything is deployed, there will be three resource groups that contain resources for each workspace.  
These resources and resource groups are named with the workspace as a suffix, so that they are easily identifiable.  
Most resources also have a tag with the workspace name, so that they are also easily identifiable in the Azure portal.  

You can run the terraform commands manually, or you can use the GitHub Actions workflow to run the commands.  

To run the terraform commands manually, you can use the following commands:

```bash
terraform init
terraform plan -var-file="terraform.tfvars" -out="planfile"
terraform apply "planfile"
```

To destroy the infrastructure, you can use the following commands:

```bash
terraform destroy
```

Make sure this is done in the correct workspace, or else you will destroy the wrong infrastructure, or get an error.



## Showcase of Successful Workflow

The following screenshots show the successful workflow and the deployed infrastructure.  
These can also be viewed publicly on my GitHub profile: [IIKG3005](https://github.com/OblivionLimbo/IIKG3005)

### Apply to Dev

#### Workflow in GitHub
**Successful Workflow**
- Waiting for approval to apply infrastructure to prod
- The complete run of the workflow can be found [here](https://github.com/OblivionLimbo/IIKG3005/actions/runs/6762039673/job/18377548587)

![Successful Workflow](https://cdn.discordapp.com/attachments/1156933138828759111/1170740270111920158/image.png?ex=655a23d7&is=6547aed7&hm=9739e442b2fc3ceef89d7b91fc78328aa5c3692c4c4868d13b91d4bb87b822d2&)

**Terraform Validate**  
![Terraform Validate](https://cdn.discordapp.com/attachments/1156933138828759111/1170740695707955220/image.png?ex=655a243d&is=6547af3d&hm=cdcc529f90f23b45b8d762b89bdf9c3a182745d63b87aff2a34e77c9dc736e89&)

**tflint**  
![tflint](https://cdn.discordapp.com/attachments/1156933138828759111/1170740780428693615/image.png?ex=655a2451&is=6547af51&hm=93a9df73bf60593b2f3d30dd4ca322ff381a95df5f96ec438bf6bbe8b4630703&)

**tfsec**  
![tfsec](https://cdn.discordapp.com/attachments/1156933138828759111/1170740898552889445/image.png?ex=655a246d&is=6547af6d&hm=c897ddfe80861919c773dcc08bc10f18f8b957074914e9eff73e41060960003d&)

![tfsecfail](https://cdn.discordapp.com/attachments/1156933138828759111/1170740899412725780/image.png?ex=655a246d&is=6547af6d&hm=091280a00cf8463e9847e30d213e65d9af86cc9961ff50eec7d45ef320127d10&)

As stated above, the tfsec workflow fails as there are some security issues in the terraform scripts, but I have not fixed them.

**Terraform Plan**  
![plan](https://cdn.discordapp.com/attachments/1156933138828759111/1170741973896941699/image.png?ex=655a256d&is=6547b06d&hm=ddb69148266b6e8bba1e902c8f6c8d1047015558a7130254ae6470826e6ec861&)

**Infrastructure Applied**  
![applied](https://media.discordapp.net/attachments/1156933138828759111/1170741748918653009/image.png?ex=655a2538&is=6547b038&hm=d3ca8219b74eaecafdfb6e8dc754970c2d0023715a6a4ceab2d3b3705fdefcc8&=&width=470&height=676)

#### Azure Portal

> I will omit showing all of the items in the Azure portal, as there are a lot of them, and it would take a lot of space.
> I will show the resource groups, and some of the resources in the resource groups, such as the web container and the static web page.

**Resource Group**  
![rg-dev](https://cdn.discordapp.com/attachments/1156933138828759111/1170742778016317480/image.png?ex=655a262d&is=6547b12d&hm=4455ddb5a023ad835b6dc65be5dac1b04f82c8d20c05983bf74241591812ab93&)

**Web Container**  
![web-container](https://media.discordapp.net/attachments/1156933138828759111/1170743016781254697/image.png?ex=655a2666&is=6547b166&hm=d6322480f3926b148151f1a7de9909a63c41666321f9a57f95b22fa508896fc5&)

**Static Website**  
![static website](https://cdn.discordapp.com/attachments/1156933138828759111/1170742909377724456/image.png?ex=655a264c&is=6547b14c&hm=e6484eeb6220157a0ff076bdc0a9270657430b30b9f85652345a224febab1715&)

There is no output in the Github workflow for the static website endpoint URL, because I use modules, but it can be found in the Azure portal, under the static website blade.

![static website](https://cdn.discordapp.com/attachments/1156933138828759111/1170743757025583294/image.png?ex=655a2717&is=6547b217&hm=b535ff70756b569e209cd1536a4dd972d9ef3408259375a1f6bcfacd58ee12f8&)

### Apply to All

Commiting with **apply all** in the commit message will run the terraform apply command for all workspaces, and deploy the infrastructure for all workspaces.

> I will skip most of the workflow for this, but showcase that you need to approve prod, and that it will apply to all workspaces.

> Dev will not be applied again, as it is already applied, and I will not showcase it again here. 

**Successful Workflow**  
- Waiting for approval to apply infrastructure to prod

![prod](https://cdn.discordapp.com/attachments/1156933138828759111/1170745419760943134/image.png?ex=655a28a3&is=6547b3a3&hm=8127190fe51a9b7b6dfef9c821926594e167ef17f1a3207749c7bed21cc1fcc3&)

![workflow](https://cdn.discordapp.com/attachments/1156933138828759111/1170745488417501274/image.png?ex=655a28b3&is=6547b3b3&hm=1234b9cd429cb214c08a598bc8bfe3c851f674e3214d86510b61bb54d1f2abf8&)

**Approving for Prod**  
![approval](https://cdn.discordapp.com/attachments/1156933138828759111/1170745552829431839/image.png?ex=655a28c3&is=6547b3c3&hm=e72ab5b4bcb6e97c63d7fc84e1f7393af02ee0949ba6411bd86dd6b7f05458d8&)

**Workflow Completed**  
![workflow complete](https://cdn.discordapp.com/attachments/1156933138828759111/1170749821141913660/image.png?ex=655a2cbc&is=6547b7bc&hm=b9068af79484cb5d2a5fffd4fbeb578996adc19ae757a8acd6a08f1ffdceeb02&)

**Stage**  
![resource group](https://cdn.discordapp.com/attachments/1156933138828759111/1170751788857688155/image.png?ex=655a2e91&is=6547b991&hm=ed7d0fb3b9c811284ff64dd59a086c6ec97456adba2d7fad8f2009246eedadbc&)

![webpage](https://cdn.discordapp.com/attachments/1156933138828759111/1170751789163880560/image.png?ex=655a2e92&is=6547b992&hm=ec672798959aeaee6c7356102f5957115162e35c8c140d2bba8009a208980894&)

![static](https://cdn.discordapp.com/attachments/1156933138828759111/1170751789428129802/image.png?ex=655a2e92&is=6547b992&hm=450d719d6870f61380b370fcb197b110f002f3b1e3f587e264d97801689e124e&)

**Prod**  
![resource group](https://cdn.discordapp.com/attachments/1156933138828759111/1170751911889215578/image.png?ex=655a2eaf&is=6547b9af&hm=9a366bfca3b9f4b1c0f717e3808303f73b86d3fe6e7a26145b8a59740f029ca4&)

![webpage](https://cdn.discordapp.com/attachments/1156933138828759111/1170751912245739631/image.png?ex=655a2eaf&is=6547b9af&hm=91b4e5f07180ea4b46080a699fac055879eea04139a38b150dfd4211f9e943a8&)

![static](https://cdn.discordapp.com/attachments/1156933138828759111/1170751912606437427/image.png?ex=655a2eaf&is=6547b9af&hm=f0b5fd4e8cb85b060e01c8373601ff0e15debe8df97a42413b2cf14bf0bc084d&)

### Destroy All

Commiting with **destroy all** in the commit message will cancel the terraform destroy command for all workspaces, and destroy the infrastructure for all workspaces.  
The full workflow can be viewed [here](https://github.com/OblivionLimbo/IIKG3005/actions/runs/6762300761/job/18378165971)

![workflow](https://cdn.discordapp.com/attachments/1156933138828759111/1170755628080312360/image.png?ex=655a3225&is=6547bd25&hm=9b31e8b567df94e6361d245e77ce09bf009545260322804d0b6a2d722aa668ea&)

**Before Destroy**  
![resource groups](https://cdn.discordapp.com/attachments/1156933138828759111/1170752718248366210/image.png?ex=655a2f6f&is=6547ba6f&hm=cf79e7b410b5684640ef3ce90b02a295d331e0cd94617224bb31da6c315be05e&)

**After Destroy**  
![resource groups](https://cdn.discordapp.com/attachments/1156933138828759111/1170755597608681523/image.png?ex=655a321e&is=6547bd1e&hm=df20aaeeb98040b55ccab4630543958ee1e04349e32f551d7c72b47f01ea6f13&)

**Dev**  
![dev](https://cdn.discordapp.com/attachments/1156933138828759111/1170755789741359134/image.png?ex=655a324b&is=6547bd4b&hm=3da553e8788788549f60e68d0f918351690ae3553bced3cae9c049732937bd78&)

**Stage**  
![stage](https://cdn.discordapp.com/attachments/1156933138828759111/1170755867759616090/image.png?ex=655a325e&is=6547bd5e&hm=3c0df7a9613189062eb10b1c05e8a87e57b6acd8aa0e7df558c0d005c46c52c5&)

**Prod**  
![prod](https://cdn.discordapp.com/attachments/1156933138828759111/1170755975599370250/image.png?ex=655a3278&is=6547bd78&hm=b41cead6769a29a14959eac7c6fa04937ac2abb6251b1ea70cb7631790f86f55&)