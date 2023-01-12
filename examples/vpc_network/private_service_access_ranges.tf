locals {
  private_service_access_ranges = {
    psatest1 = {
      address       = "192.168.76.0"
      prefix_length = "24"
    }
    psatest2 = {
      address       = "192.168.5.0"
      prefix_length = "24"
    }
    psatest3 = {
      address       = "192.168.40.0"
      prefix_length = "24"
    }
  }
}
