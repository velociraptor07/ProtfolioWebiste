terraform {
  backend "azurerm" {
    resource_group_name   = "yash-tfstate-rg"
    storage_account_name  = "yashtfstateczukxo"   
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "yash-tfstate-rg"
  location = "Australia Central"
}

resource "azurerm_storage_account" "sa" {
  name                     = "yashtfstate${random_string.suffix.result}" 
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "random_string" "suffix" {
  length  = 6
  lower   = true
  upper   = false
  numeric = true
  special = false
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}
