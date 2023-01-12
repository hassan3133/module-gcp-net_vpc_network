# Common
variable "project" {
  description = "Project ID"
  type        = string
}

# VPC network peering
variable "network" {
  description = "The name of the network to which peering is related"
  type        = string
}

variable "vpc_network_peers" {
  description = "vpc network peer definitions."
  type = map(object({
    peer_project_name                   = string
    peer_vpc_network_name               = string
    export_custom_routes                = bool
    import_custom_routes                = bool
    export_subnet_routes_with_public_ip = bool
    import_subnet_routes_with_public_ip = bool
  }))
  default = {}
}
