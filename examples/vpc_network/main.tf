/******************************************
	VPC network module example
 *****************************************/
module "vpc_network" {
  source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_network"
  # source = "../../modules/vpc_network"

  name                              = "pl-sandbox"                            # required at minimum, provide network name
  project                           = var.project                             # required at minimum
  description                       = ""                                      # only required if you need to provide a description
  auto_create_subnetworks           = false                                   # only required if you need to change its value from false to true
  routing_mode                      = "GLOBAL"                                # only required if you need to change its value from GLOBAL to REGIONAL
  mtu                               = 0                                       # only required if you need to change its value between 1461 and 1500. 0 defaults to 1460
  delete_default_routes_on_create   = false                                   # only required if you need to change its value from false to true
  private_service_access            = false                                   # only required if network needs private service access. Has to be set to true to trigger creation of PSA ranges
  private_service_access_ranges     = local.private_service_access_ranges     # configure PSA ranges in private_service_access_ranges.tf file
  private_service_connect           = false                                   # only required if network needs private service connect. Has to be set to true to trigger creation of PSC endpoints
  private_service_connect_endpoints = local.private_service_connect_endpoints # configure PSC endpoints in private_service_connect_endpoints.tf file
  vpc_network_peering               = false                                   # only required if VPC network peering is required. Has to be set to true to trigger creation of VPC network peers.
  vpc_network_peers                 = local.vpc_network_peers                 # configure VPC network peers in vpc_network_peers.tf file
  network_tier                      = "PREMIUM"                               # only required if you need to change its value from PREMIUM to STANDARD.
}
