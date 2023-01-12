variable "project" {
  description = "Project ID required by google_compute_shared_vpc_host_project resource"
  type        = string
}

variable "shared_vpc_host" {
  description = "Makes this project a Shared VPC host if 'true'"
  type        = bool
  default     = false
}

variable "shared_vpc_service_projects" {
  description = "shared_vpc_service_project definitions"
  type        = set(string)
  default     = []
}
