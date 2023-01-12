output "id" {
  description = "VPC network identifier with format projects/{{project}}/global/networks/{{name}}"
  value       = google_compute_network.network.id
}

output "gateway_ipv4" {
  description = "The gateway address for default routing out of the network. This value is selected by GCP."
  value       = google_compute_network.network.gateway_ipv4
}

output "network_self_link" {
  description = "The URI of the created VPC network."
  value       = google_compute_network.network.self_link
}
