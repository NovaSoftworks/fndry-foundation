variable "billing_account_id" {
  type        = string
  description = "The alphanumerical ID of the billing account in Google Cloud to use for the environment."
}

variable "resources_prefix" {
  type        = string
  description = "The name to use as prefix in resources names (e.g. novacp)."
}

variable "parent_id" {
  type        = string
  description = "The ID of the parent folder or organization where the environment folder will be created 9 (e.g. folder/123456789)."
}

variable "short_name" {
  type        = string
  description = "The 3 characters long name of the environment (e.g. prd)."

  validation {
    condition     = length(var.short_name) == 3
    error_message = "The short name of the environment must be 3 characters long."
  }
}
