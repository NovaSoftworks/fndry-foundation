resource "google_folder" "env_folder" {
  parent              = var.parent
  display_name        = "${var.name}"
  deletion_protection = false # TODO: remove after POC
}

resource "google_folder" "env_platforms_folder" {
  parent              = google_folder.env_folder.id
  display_name        = "platforms"
  deletion_protection = false # TODO: remove after POC
}