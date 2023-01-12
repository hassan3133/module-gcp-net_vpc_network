# Common
variable "project" {
  description = "Project ID"
  type        = string
}

# VPC network
variable "name" {
  description = "The name of the network being created"
  type        = string
}

variable "description" {
  description = "An optional description of the network. The resource must be recreated to modify this field."
  type        = string
  default     = ""
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are REGIONAL and GLOBAL."
  type        = string
  default     = "GLOBAL"
}

variable "mtu" {
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  type        = number
  default     = 0
}

variable "delete_default_routes_on_create" {
  description = "If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation."
  type        = bool
  default     = false
}

# project default network tier
variable "network_tier" {
  description = "The default network tier to be configured for the project. This field can take the following values: PREMIUM or STANDARD."
  type        = string
  default     = "PREMIUM"
}

# private service access
variable "private_service_access" {
  description = "Creates private service access ranges if set to 'true'"
  type        = bool
  default     = false
}

variable "private_service_access_ranges" {
  description = "private_service_access range definitions."
  type = map(object({
    address       = string
    prefix_length = number
    # ip_version = optional(string)
  }))
  default = {}
}

# private service connect
variable "private_service_connect" {
  description = "Creates private service connect endpoints if set to 'true'"
  type        = bool
  default     = false
}

variable "private_service_connect_endpoints" {
  description = "private_service_connect endpoint definitions."
  type = map(object({
    address = string
    target  = string
  }))
  default = {}
}

# VPC network peering
variable "vpc_network_peering" {
  description = "Creates vpc network peers if set to 'true'"
  type        = bool
  default     = false
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
