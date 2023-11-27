provider "google"{
    credentials = file(var.gcp_auth_key)
    project = var.gcp_project
    region = var.gcp_region
}