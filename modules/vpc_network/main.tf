/******************************************
	VPC Network Resource
 *****************************************/
resource "google_compute_network" "network" {
  name                            = var.name
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = var.delete_default_routes_on_create
  description                     = var.description
  mtu                             = var.mtu
  routing_mode                    = var.routing_mode
}

/******************************************
	Project Default Network Tier Resource
 *****************************************/
resource "google_compute_project_default_network_tier" "default" {
  network_tier = var.network_tier
}

/******************************************
	Private Service Access Resources
 *****************************************/
resource "google_compute_global_address" "private_service_access" {
  for_each      = var.private_service_access ? var.private_service_access_ranges : {}
  name          = each.key
  purpose       = "VPC_PEERING"
  address       = each.value.address
  prefix_length = each.value.prefix_length
  address_type  = "INTERNAL"
  network       = google_compute_network.network.name
}

resource "google_service_networking_connection" "private_service_access" {
  count                   = var.private_service_access ? 1 : 0
  network                 = google_compute_network.network.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = keys(var.private_service_access_ranges)

  # There is a "hidden" dependency on the google_compute_global_address
  # that Terraform cannot automatically infer, so it must be declared explicitly:
  depends_on = [
    google_compute_global_address.private_service_access
  ]
}

/******************************************
	Private Service Connect Resources
 *****************************************/
resource "google_compute_global_address" "private_service_connect" {
  for_each     = var.private_service_connect ? var.private_service_connect_endpoints : {}
  provider     = google-beta
  name         = each.key
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = google_compute_network.network.name
  address      = each.value.address
}

resource "google_compute_global_forwarding_rule" "private_service_connect" {
  for_each              = var.private_service_connect ? var.private_service_connect_endpoints : {}
  provider              = google-beta
  name                  = each.key
  target                = each.value.target
  network               = google_compute_network.network.name
  ip_address            = google_compute_global_address.private_service_connect[each.key].id
  load_balancing_scheme = ""
}

/******************************************
	VPC Network Peering Resource
 *****************************************/
resource "google_compute_network_peering" "peer" {
  for_each                            = var.vpc_network_peering ? var.vpc_network_peers : {}
  name                                = each.key
  network                             = google_compute_network.network.id
  peer_network                        = "projects/${each.value.peer_project_name}/global/networks/${each.value.peer_vpc_network_name}"
  export_custom_routes                = each.value.export_custom_routes
  import_custom_routes                = each.value.import_custom_routes
  export_subnet_routes_with_public_ip = each.value.export_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = each.value.import_subnet_routes_with_public_ip
}
