# Locals, variables and output
In todays assignment we are going to test the following:  
With the knowledge of locals, list and maps, we kan now create variables with an list of names or values. Create a new working directory and the following files
- main.tf
- locals.tf
- variables.tf
- terraform.tfvars

The terraform configuration are requested to have the following:
- Resource Group for networking, with the following
  - two VNET with two subnet
  - NSG for the two subnets
- Resource Group for storage accounts, with the following
  - Three storage accounts

All Resource Groups and Resources must have a tag that tells the company, which project, billing department and owner.

How will you create this infrastructure with the knowledge of locals, list, maps, and input variables?

Hints:  
[count](https://developer.hashicorp.com/terraform/language/meta-arguments/count): determines the length of a given list, map, or string  
Can be used to get multiple names to resources with one resource block:  
count = length(var.storage_account_names)  
name = var.storage_account_names[count.index]  

Is there any output that could come in handy with this kind of deployment?