/******************************************
	shared VPC module example
 *****************************************/
module "shared_vpc" {
  source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/shared_vpc"

  project                     = var.project                       # required at minimum
  shared_vpc_host             = true                              # required at minimum. Has to be set to true to define local project as host and projects in shared_vpc_service_projects.tf as service projects
  shared_vpc_service_projects = local.shared_vpc_service_projects # required at minimum. Configure service projects in shared_vpc_service_projects.tf file
}
