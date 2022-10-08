resource "azurerm_resource_group" "this" {
  name     = "${var.name}-sampleapp"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.name}sampleapp"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "this" {
  name                = "${var.name}-sampleapp"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "sampleapp" {
  name                = "${var.name}-sampleapp"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location

  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  service_plan_id            = azurerm_service_plan.this.id

  site_config {}
}
