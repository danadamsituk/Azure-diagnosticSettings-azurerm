##################################################
#                 Module Outputs                 #
##################################################

output "diagnostic_setting_ids" {
  description = "The IDs of the Diagnostic Settings."
  value       = length(azurerm_monitor_diagnostic_setting.azurerm_monitor_diagnostic_setting) > 0 ? azurerm_monitor_diagnostic_setting.azurerm_monitor_diagnostic_setting[*].id : []
}

output "diagnostic_setting_names" {
  description = "The names of the Diagnostic Settings."
  value       = length(azurerm_monitor_diagnostic_setting.azurerm_monitor_diagnostic_setting) > 0 ? azurerm_monitor_diagnostic_setting.azurerm_monitor_diagnostic_setting[*].name : []
}
