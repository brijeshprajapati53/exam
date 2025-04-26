provider "azurerm" {
  features {}
  subscription_id = "c1ff822a-8d32-49f1-b97a-89c2b2a1b55e"
}

resource "azurerm_resource_group" "main" {
  name     = "examresource"
  location = "East US 2"
}



resource "azurerm_storage_account" "exam_sa" {
  name                     = "storagebrijesh678"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_container_registry" "acr" {
  name                = "acrbrijesh123"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}
