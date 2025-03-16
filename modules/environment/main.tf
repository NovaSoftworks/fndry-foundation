resource "google_folder" "env_folder" {
  parent              = var.parent
  display_name        = "${var.name}"
  deletion_protection = false # TODO: remove after POC
}