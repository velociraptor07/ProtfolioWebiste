terraform {
  backend "azurerm" {
    # Remote state (pre-existing, do not manage with TF)
    resource_group_name  = "yash-tfstate-rg"
    storage_account_name = "yashtfstate565896"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -------- Managed APP infrastructure --------
resource "azurerm_resource_group" "app_rg" {
  name     = "yash-portfolio-rg"
  location = "Australia Central"
}

resource "azurerm_service_plan" "plan" {
  name                = "yash-portfolio-plan"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  os_type             = "Windows"
  sku_name            = "S1"
}

resource "azurerm_windows_web_app" "app" {
  name                          = "yash-portfolio-new"
  location                      = azurerm_resource_group.app_rg.location
  resource_group_name           = azurerm_resource_group.app_rg.name
  service_plan_id               = azurerm_service_plan.plan.id
  https_only                    = true
  public_network_access_enabled = true

  site_config {
    minimum_tls_version         = "1.2"
    ftps_state                  = "Disabled"
    always_on                   = true
    http2_enabled               = true
    scm_use_main_ip_restriction = false
  }
}

output "app_url" {
  value = "https://${azurerm_windows_web_app.app.default_hostname}"
}
