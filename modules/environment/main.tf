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
