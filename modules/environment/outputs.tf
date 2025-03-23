output "shared_vpc_host_project_id" {
  value = google_compute_shared_vpc_host_project.vpc_host.project
}

output "shared_vpc_id" {
  value = google_compute_network.vpc.network_id
}

output "platforms_folder_id" {
  value = google_folder.env_platforms_folder.folder_id
}
