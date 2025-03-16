variable "parent" {
  type = string
  description = "The parent folder or organization where the environment folder will be created."
}

variable "name" {
  type        = string
  description = "The full name of the environment (e.g. production)."
}

variable "short_name" {
  type        = string
  description = "The short name of the environment (e.g. prd)."

  validation {
    condition     = length(var.short_name) == 3
    error_message = "The short name of the environment must be 3 characters long."
  }
}
