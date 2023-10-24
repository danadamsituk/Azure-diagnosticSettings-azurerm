##################################################
#                 Module Variables               #
##################################################

variable "resource_id" {
  type = string
}
variable "log_analytics_workspace_id" {
  type = string
  default = null
}
variable "log_analytics_destination_type" {
  type    = string
  default = null
  validation {
    condition     = var.log_analytics_destination_type == null || can(contains(["Dedicated", "AzureDiagnostics"], var.log_analytics_destination_type))
    error_message = "The log_analytics_destination_type must be either 'Dedicated', 'AzureDiagnostics', or null."
  }
}
variable "storage_account_id" {
    type = string
    default = null 
}
variable "diagnostic_setting_mode" {
  description = "Mode for configuring diagnostics: Full, None, or Custom."
  type        = string
  default     = "Full"

  validation {
    condition     = contains(["Full", "None", "Custom"], var.diagnostic_setting_mode)
    error_message = "The diagnostic_setting_mode variable must be set to Full, None, or Custom."
  }
}
variable "custom_diagnostics_settings" {
  description = "Custom diagnostics settings for category groups and metrics."
  type        = object({
    category_groups = list(string)
    metrics         = list(string)
  })
  default = null
}

