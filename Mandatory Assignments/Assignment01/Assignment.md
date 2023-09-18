# Terraform Mandatory Assignment: Infrastructure as Code (IaC) for an IT Consultant Firm

## Objective 

The goal of this assignment is to develop a reusable Terraform project that uses modules to provision and manage differente Azure resources like VNET, VM, Storage Account, and Key Vault. This project would serve as a foundation for deploying similar infrastructure for multiple clients in the future. 

## Use-Case Scenario

You are a junior IT consultant at "OperaTerra AS", and you have been assigned the task of creating a Terraform Project to manage Azure resources for multiple clients. This project should be scalable, secure, and easily maintainable. 

## Requirements

### Initialization & Basic Commands

Initialize a new Terraform configuration using terraform init.   
Make sure to document how one can use terraform plan and terraform apply to create resources, and terraform destroy to remove them. 

### Variables & Outputs

- Use Input Variables to make configuration flexible. Create variables for: 
  - Resource group names
  - Location
  - Storage Account types
  - SKU
  - VM Sizes
  - etc. 
  - .. and where you see it most fit for flexibility. 
- If needed, use locals to set common attributes or compose new values for existing ones. 

- Use Outputs to make sure you get the information needed from child modules and root module. This could be: 
  - Public IP of the VM
  - Subnet ID
  - Key Vault Secret ID
  - etc.
  - ...

## Modules

Create the following child modules: 
- **Network Module**: To provision VNET, Subnet, and Network Security Group. 
- **Storage Account Module**: To create an Azure Storage Account and a Storage Container. 
- **Virtual Machine Module**: To provision an Azure Virtual Machine. 
- **Key Vault Module**: To provision Azure Key Vault and store secret. 

Use the root module to orchestrate these child modules. 

Make sure to use outputs in child modules to pass information back to the root module or other child modules to make the configuration as flexible as possible. 

## Azure Resources 

Resources to Create: 
- VNET with at least one subnet
- At least one VM connected to the subnet
- At least one NSG that protects the VM from outside threats
- Azure Storage Account with at least one storage container
- Azure Key Vault with the following secrets: 
  - A secret holding the VM username and password
  - A secret holding the Storage Account Access Key
- The VM should use the Key Vault VM secret with username and password

## Deliverables

IMPORTANT! A .zip-file with the following name, files and folders: Name the zip file with the ntnu username and oppg1, such as: melling-oppg1.zip In the zip file there must be a folder with the same name as the zip file: ntnuusername-oppg1, such as: melling-oppg1. The folder naturally contains the terraform files and folders. The reason for the naming is to streamline censorship and display in VS Code.

Terraform configuration:  
Terraform scripts for all modules and the root module.

A [README.md](./kristoju-oppg1/README.md) file explaining:
- The purpose of each module
- How to use the Terraform scripts
- Any pre-requisites or dependencies

A sample .tfvars file containing sample values for all the input variables.  
Output screenshots showing the successful application deployed and destruction of resources.

## Evaluation Criteria

Code quality, functionality, documentation, reusability

## Deadline

**02. October 2023 - 23:59**