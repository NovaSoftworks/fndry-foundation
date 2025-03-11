variable "organization" {
  type        = string
  description = "The domain of the organization to create resources in (e.g. novasoftworks.com)."
}

variable "billing_account" {
  type        = string
  description = "The name of the billing account in Google Cloud to use for the bootstrap."
}
