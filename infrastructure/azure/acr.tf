# acr.tf
resource "azurerm_container_registry" "acr" {
  name                = "microservicesacr${random_integer.rand.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}
