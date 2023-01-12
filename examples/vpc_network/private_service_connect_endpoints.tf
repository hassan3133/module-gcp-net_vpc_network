locals {
  private_service_connect_endpoints = {
    psctest1 = {
      address = "192.168.102.2"
      target  = "all-apis"
    }
    psctest2 = {
      address = "192.168.200.2"
      target  = "all-apis"
    }
    psctest3 = {
      address = "192.168.80.245"
      target  = "vpc-sc"
    }
  }
}
