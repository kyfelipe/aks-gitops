terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }

  required_version = "~> 0.14"
}
