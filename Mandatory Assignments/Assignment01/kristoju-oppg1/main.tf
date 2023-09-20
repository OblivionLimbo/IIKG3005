terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "2.46.0"
        }
    }
}

provider "azurerm" {
    features {}
}

module "keyvault" {
    source = "./keyvault"
}

module "StorageAccount" {
    source = "./storageaccount"
}

module "Network" {
    source = "./network"
}

module "VirtualMachine" {
    source = "./virtualmachine"
}

