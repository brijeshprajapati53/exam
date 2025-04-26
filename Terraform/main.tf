provider "azurerm" {
  features {}
  subscription_id = "c1ff822a-8d32-49f1-b97a-89c2b2a1b55e"
}

resource "azurerm_resource_group" "exam_rg" {
  name     = "examResourceGroup"
  location = "East US"
}

resource "azurerm_storage_account" "exam_sa" {
  name                     = "storageaccountbrijesh001"
  resource_group_name      = azurerm_resource_group.exam_rg.name
  location                 = azurerm_resource_group.exam_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
