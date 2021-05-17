terraform {
  backend "azurerm" {
    resource_group_name  = "default"
    storage_account_name = "felipestate785"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
