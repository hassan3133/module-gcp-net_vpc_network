locals {
  vpc_network_peers = {
    vpc-peer1 = {
      peer_project_name                   = "test-project-pl-1"
      peer_vpc_network_name               = "test-network1"
      export_custom_routes                = false
      import_custom_routes                = false
      export_subnet_routes_with_public_ip = true
      import_subnet_routes_with_public_ip = false
    }
    vpc-peer2 = {
      peer_project_name                   = "test-project-pl-2"
      peer_vpc_network_name               = "test-network2"
      export_custom_routes                = true
      import_custom_routes                = true
      export_subnet_routes_with_public_ip = true
      import_subnet_routes_with_public_ip = false
    }
  }
}
