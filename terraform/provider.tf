terraform {
    
  backend "azurerm" {
    resource_group_name   = "tf-RG"
    storage_account_name  = "ntmstfsa"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "6b0a7b1e-2617-4e28-9ddd-923b60484baf"
  client_id       = "b68d74aa-8da7-4558-afc7-f181ccda025c"
  client_secret   = var.client_secret
  tenant_id       = "aac90c8d-130f-4c13-95f4-83d854fccb4a"
}
