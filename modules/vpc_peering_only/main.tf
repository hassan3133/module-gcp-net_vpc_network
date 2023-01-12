/******************************************
	VPC Network Peering Resource
 *****************************************/
resource "google_compute_network_peering" "peer" {
  for_each                            = var.vpc_network_peers
  name                                = each.key
  network                             = "projects/${var.project}/global/networks/${var.network}"
  peer_network                        = "projects/${each.value.peer_project_name}/global/networks/${each.value.peer_vpc_network_name}"
  export_custom_routes                = each.value.export_custom_routes
  import_custom_routes                = each.value.import_custom_routes
  export_subnet_routes_with_public_ip = each.value.export_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = each.value.import_subnet_routes_with_public_ip
}
