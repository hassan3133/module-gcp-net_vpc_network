/******************************************
	VPC network module outputs
 *****************************************/
output "network_self_link" {
  value = module.vpc_network.network_self_link
}

output "id" {
  value = module.vpc_network.id
}

output "gateway_ipv4" {
  value = module.vpc_network.gateway_ipv4
}
