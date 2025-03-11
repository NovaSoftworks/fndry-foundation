data "google_organization" "org" {
  domain = var.organization
}

data "google_billing_account" "acct" {
  display_name = var.billing_account
  open         = true
}

locals {
  organization_id    = data.google_organization.org.org_id
  billing_account_id = data.google_billing_account.acct.id
}

resource "google_folder" "nvcld_folder" {
  parent              = "organizations/${local.organization_id}"
  display_name        = "nvcld"
  deletion_protection = false # TODO: remove after POC
}
