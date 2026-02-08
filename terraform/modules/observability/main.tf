resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = var.retention_days
  tags              = var.tags
}

resource "azurerm_kubernetes_cluster_extension" "azure_monitor" {
  name           = "azuremonitor-containers"
  cluster_id     = var.aks_cluster_id
  extension_type = "Microsoft.AzureMonitor.Containers"

  configuration_settings = {
    logAnalyticsWorkspaceResourceID = azurerm_log_analytics_workspace.this.id
  }
}

resource "azurerm_monitor_action_group" "this" {
  count               = var.alert_email == null ? 0 : 1
  name                = "${var.name}-ag"
  resource_group_name = var.resource_group_name
  short_name          = "platform"

  email_receiver {
    name          = "email"
    email_address = var.alert_email
  }
}

resource "azurerm_monitor_metric_alert" "node_not_ready" {
  count               = var.alert_email == null ? 0 : 1
  name                = "${var.name}-node-not-ready"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_cluster_id]

  severity    = 2
  frequency   = "PT5M"
  window_size = "PT5M"
  description = "AKS node not ready"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_status_condition"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0
  }

  action {
    action_group_id = azurerm_monitor_action_group.this[0].id
  }
}