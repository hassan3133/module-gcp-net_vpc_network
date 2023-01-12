/*****************************
	VPC Network Peering
 *****************************/
module "vpc_peering_external_data1" {
  source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_peering_only"

  network = "test-network3"
  project = var.project

  vpc_network_peers = local.vpc_network_peers
}
