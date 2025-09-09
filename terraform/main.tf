terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.0" }
    random  = { source = "hashicorp/random",  version = "~> 3.0" }
  }
}

provider "azurerm" {
  features {}
}

# Unique suffix for global name uniqueness
resource "random_string" "suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = true
  special = false
}

# Resource Group in Australia Central
resource "azurerm_resource_group" "rg" {
  name     = "yash-portfolio-rg"
  location = "Australia Central"
}

# App Service Plan (PAID: Standard S1)
resource "azurerm_service_plan" "plan" {
  name                = "yash-portfolio-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"  # change to "Linux" if you want linux_web_app
  sku_name            = "S1"
}

# Web App (Windows)
resource "azurerm_windows_web_app" "app" {
  name                = "yash-portfolio-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  site_config {
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"
    always_on           = true
    http2_enabled       = true
  }
}

# Output the public URL
output "app_url" {
  value = "https://${azurerm_windows_web_app.app.default_hostname}"
}
