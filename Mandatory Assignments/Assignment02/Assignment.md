# Terraform Mandatory Assignment: CI/CD and testing
 
The goal of this assignment is to create a good CI/CD workflow with for our Terraform IaC with Github Actions.
 
## Initial setup
Use a small and simple known infrastructure (could be module 7 demo-infra from already known git repo: https://github.com/torivarm/iac-terraform.git). Set up secrets in your GitHub repository for Azure credentials and any other sensitive informasjon. Configure the Terraform AzureRM backend to store the state files in Azure Storage Account. Make sure the backend configuration supports workspaces by making the storage key dynamic based on the workspace name.

## Use-Case senario
OperaTerra AS has caught traction in the IT market and famous for its skilled junior consultants. To keep up with the market and its demands, they now have to implement a good CI/CD workflow for its customers that already have a good scalable, secure, and easily maintainable Terraform code base. Customers wants a presentation of different approaches for how to implement a good practice for CI/CD with both workspaces and use of branches.
 
## The to-do:
### Customer requirements – Use of workspaces and Git branches
* Three workspaces with the following names: dev, stage and prod
* Terraform code base must include workspace-specific configurations (such as names, tags, etc.)
* For infrastructure configuration it should be created branches (remember good naming convention and life cycle) that should undergo code reviews (terraform fmt, terraform validate and tflint) before they are merged into the environment branches (e.g., dev, staging, prod), which providing a layer of quality assurance.
* Create Pull Request to perform merging with environment branches.
  * Merging with environment branches should trigger a workflow that will plan and apply infrastructure to workspaces except prod
    * For deployment of infrastructure in prod it must be aproved by a minimum of one person.
 
 
## Deliverables
**IMPORTANT!** A .zip-file with the following name, files and folders: 
* Name the zip file with the ntnu username and oppg2, such as: 
  * melling-oppg2.zip 
* In the zip file there must be a folder with the same name as the zip file: 
  * ntnuusername-oppg1, such as: melling-oppg2. 
* The folder naturally contains the terraform files and folders. 
The reason for the naming is to streamline censorship and display in VS Code.

A README.md file explaining:
* How to use the Terraform scripts
* Any pre-requisites or dependencies
* A terraform.tfvars file containing values for all the input variables.
* Output screenshots showing the successful workflow and the deployed infrastructure. Remember to destroy resources when you are done.

## Evaluation Criteria
* Code quality, functionality, documentation, reusability.

## Deadline
**05. November 2023 - 23:59**