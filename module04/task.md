# Modules and output
In todays assignment we are going to do the following:  
We have now the knowledge of modules added to all the previous lecures.  
Create a new working directory for this weeks assignment, which is going to be our root module. Create subfolders which is going to reprensent different parts of the infrastructure.  

The infastructure is going to consist of:
- Virtual Network with a subnet and a NSG added to the subnet
   - The NSG should only allow SSH inbound from your PC public IP
     (https://whatismyipaddress.com)
- A VM (Linux) with a public IP-address which you can access.
   - I know the video shows how to create a VM with the password in clear text, but we will cover how to work with secrets etc. in the next lesson.

All Resource Groups and Resources must have a tag that tells the company, which project, billing department and owner. All infrastructure stacks could also have their base_name for naming convention.

How will you create this infrastructure with the knowledge from todays chapters: 
- Building Environments with Stacks
- Configuring Stack Instances
- How to input values?
- How to make sure the child modules get the correct values when called from the root module?
    - Hard coded value in the main?
    - Use of variables with the -var flag in the command line?
    - Use of .tfvar files?