locals {
  region_parts           = split("-", var.region)
  region_parts_shortened = [for part in local.region_parts : substr(part, 0, 1)]
  region_number          = try(regex("([0-9]+)", var.region) != "", false) ? regex("([0-9]+)", var.region)[0] : ""
  region_short           = "${join("", local.region_parts_shortened)}${local.region_number}"
}

data "google_compute_network" "vpc" {
  name    = var.shared_vpc_id
  project = var.shared_vpc_host_project_id
}

# NAT
resource "google_compute_router" "router" {
  project = var.shared_vpc_host_project_id
  name    = "novacp-${var.environment}-${local.region_short}-router"
  network = data.google_compute_network.vpc.self_link
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  project                            =  var.shared_vpc_host_project_id
  name                               = "novacp-${var.environment}-${local.region_short}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# DMZ
resource "google_compute_subnetwork" "dmz_subnet" {
  project       = var.shared_vpc_host_project_id
  name          = "novacp-${var.environment}-dmz-${local.region_short}-subnet"
  network       = data.google_compute_network.vpc.self_link
  region        = var.region
  ip_cidr_range = var.dmz_cidr
}

resource "google_compute_instance" "bastion" {
  name         = "novacp-${var.environment}-dmz-${local.region_short}-bastion"
  project      = var.shared_vpc_host_project_id
  zone         = "${var.region}-${var.bastion_zone}"
  machine_type = "e2-micro"

  tags = ["allow-iap-ssh-ingress"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.dmz_subnet.self_link
  }
}