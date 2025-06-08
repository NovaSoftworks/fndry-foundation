resource "google_folder" "env_folder" {
  parent              = var.parent_id
  display_name        = var.short_name
  deletion_protection = false # TODO: remove after POC
}

resource "google_folder" "env_platforms_folder" {
  parent              = google_folder.env_folder.id
  display_name        = "platforms"
  deletion_protection = false # TODO: remove after POC
}

# Shared VPC
resource "random_id" "default" {
  byte_length = 4
}

resource "google_project" "shared_project" {
  folder_id       = google_folder.env_folder.folder_id
  name            = "${var.resources_prefix}-${var.short_name}-shared"
  project_id      = "${var.resources_prefix}-${var.short_name}-shared-${random_id.default.hex}"
  billing_account = var.billing_account_id
  deletion_policy = "DELETE" # TODO: remove after POC
}

resource "time_sleep" "for_60s_after_shared_project" {
  depends_on      = [google_project.shared_project]
  create_duration = "60s"
}

resource "google_project_service" "shared_project_compute_service" {
  depends_on = [time_sleep.for_60s_after_shared_project]
  project    = google_project.shared_project.project_id
  service    = "compute.googleapis.com"

  disable_on_destroy = true # disable the service if this resource is destroyed, as it likely means a change in the overall bootstrapping logic
}

resource "google_compute_shared_vpc_host_project" "vpc_host" {
  depends_on = [google_project_service.shared_project_compute_service]

  project = google_project.shared_project.project_id
}

resource "google_compute_network" "vpc" {
  name                    = "${google_project.shared_project.name}-vpc"
  project                 = google_project.shared_project.project_id
  auto_create_subnetworks = false
  depends_on              = [google_compute_shared_vpc_host_project.vpc_host]
}

# Firewall rules
resource "google_compute_firewall" "allow_iap_ssh_ingress" {
  name    = "allow-iap-ssh-ingress"
  network = google_compute_network.vpc.name
  project = google_project.shared_project.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-iap-ssh-ingress"]
  description = "Allow IAP SSH connections to instances with the 'allow-iap-ssh' tag"
}