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

resource "google_folder" "novacp_folder" {
  parent              = "organizations/${local.organization_id}"
  display_name        = "novacp"
  deletion_protection = false # TODO: remove after POC
}

module "env_prd" {
  source = "./modules/environment"

  billing_account_id = local.billing_account_id
  parent_id          = google_folder.novacp_folder.id
  resources_prefix   = google_folder.novacp_folder.display_name
  short_name         = "prd"
}

module "env_prd_ew1_nat" {
  source = "./modules/nat"

  environment = "prd"
  region = "europe-west1"
  shared_vpc_host_project_id = module.env_prd.shared_vpc_host_project_id
  shared_vpc_id = module.env_prd.shared_vpc_id
}