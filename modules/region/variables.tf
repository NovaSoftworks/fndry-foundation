variable "environment" {
  type        = string
  description = "The 3 characters long name of the environment (e.g. prd)."

  validation {
    condition     = length(var.environment) == 3
    error_message = "The short name of the environment must be 3 characters long."
  }
}

variable "shared_vpc_host_project_id" {
  type        = string
  description = ""
}

variable "shared_vpc_id" {
  type = string
}

variable "region" {
  type        = string
  description = "The unabbreviated region where the platform will be created (e.g. europe-west4)."
}