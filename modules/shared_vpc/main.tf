/******************************************
	Shared VPC Host Project
 *****************************************/
resource "google_compute_shared_vpc_host_project" "host" {
  count   = var.shared_vpc_host ? 1 : 0
  project = var.project
}

/******************************************
	Shared VPC Service Projects
 *****************************************/
resource "google_compute_shared_vpc_service_project" "service" {
  for_each        = var.shared_vpc_host ? var.shared_vpc_service_projects : []
  host_project    = var.project
  service_project = each.key

  # There is a "hidden" dependency on the google_compute_shared_vpc_host_project
  # that Terraform cannot automatically infer, so it must be declared explicitly:
  depends_on = [
    google_compute_shared_vpc_host_project.host
  ]
}
