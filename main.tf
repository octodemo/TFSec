
terraform {
  required_version = "~> 0.13.5"
  required_providers {
    azurerm = "~> 2.33.0"
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Adrian-testOrg-Hashicorp"
    workspaces {
      name = "TF-SecTest"
    }
  }
}

provider "azurerm" {
  # skip provider rego because we are using a service principal with limited access to Azure
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_resource_group" "RSG_tfsec" {
  name     = "TF-Sec-Fail1"
  location = "Australia East"
}

resource "azurerm_network_security_group" "NSG_01" {
  name                = "NetworkMe"
  location            = azurerm_resource_group.RSG_tfsec.location
  resource_group_name = azurerm_resource_group.RSG_tfsec.name
}

resource "azurerm_network_security_rule" "Rule_100_Inbound" {
    name                       = "AllInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "0.0.0.0/0"
    destination_port_range     = "0.0.0.0/0"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.RSG_tfsec.name
    network_security_group_name = azurerm_network_security_group.NSG_01.name
  }

resource "azurerm_network_security_rule" "Rule_101_Outbound" {
    name                       = "AllOutbound"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "0.0.0.0/0"
    destination_port_range     = "0.0.0.0/0"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.RSG_tfsec.name
    network_security_group_name = azurerm_network_security_group.NSG_01.name
  }

