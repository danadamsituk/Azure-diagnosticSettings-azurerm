data "azurerm_monitor_diagnostic_categories" "azurerm_monitor_diagnostic_categories" {
  resource_id = var.resource_id
}

resource "azurerm_monitor_diagnostic_setting" "azurerm_monitor_diagnostic_setting" {
  count = var.diagnostic_setting_mode == "None" ? 0 : 1
  name                       = var.diagnostic_setting_mode == "Full" ? "fullDiagnostics" : (var.diagnostic_setting_mode == "Custom" ? "customDiagnostics" : null)
  target_resource_id         = var.resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_workspace_id != null ? var.log_analytics_destination_type : null
  dynamic "enabled_log" {
    for_each = var.diagnostic_setting_mode == "Custom" ? var.custom_diagnostics_settings.category_groups : (var.diagnostic_setting_mode == "Full" ? data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_categories.log_category_groups : [])
    content {
      category_group = enabled_log.value
    }
  }
  dynamic "metric" {
    for_each = var.diagnostic_setting_mode == "Custom" ? var.custom_diagnostics_settings.metrics : (var.diagnostic_setting_mode == "Full" ? data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_categories.metrics : [])
    content {
      category = metric.value
      enabled  = true
    }
  }
}

