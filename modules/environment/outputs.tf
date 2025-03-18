output "shared_project_id" {
  value = google_project.shared_project.project_id
}

output "shared_vpc_host_project_id" {
  value = google_compute_shared_vpc_host_project.vpc_host.project
}

output "platforms_folder_id" {
  value = google_folder.env_platforms_folder.folder_id
}
