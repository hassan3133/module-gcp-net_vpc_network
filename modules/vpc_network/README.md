## Usage

1. Use vpc_network module in the project/network/network-name/global/vpc_network/ workspace.
2. Use shared_vpc module in the project/network/network-name/global/shared_vpc/ workspace.
3. Refer to [examples/](https://github.com/pcln/terraform-gcp-net_vpc_network/tree/master/examples) for usage in a workspace.
4. If you need to get outputs, in the workspace create an [outputs.tf](https://github.com/pcln/terraform-gcp-net_vpc_network/blob/master/examples/vpc_network/outputs.tf) file including outputs you need.
   - Each workspace output requires a corresponding module output.
   - Output values will be displayed after running below commands:
     - terraform apply
     - below commands after running successful terraform apply
       - terraform refresh
       - terraform output
       - terraform output [NAME]

### Configuring a new VPC network

Below example configures `pl-example` VPC network under pcln-pl-net-example project.

1. Create below folder stucture within the project directory.

    ```bash
    pcln-pl-net-example
    └── network
        └── pl-example
            └── global
                └── vpc_network
    ```

2. At minmum configure below in `main.tf` within the vpc_network folder.

   ```hcl
   module "vpc_network" {
     source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_network"

     name    = "pl-example"
     project = var.project
   }
   ```

3. If this is a new project request clouddev team to create project directory and jenkins jobs for new workspaces. Define env, project, provider, variables, and versions within the project workspace.

### Configuring network tier

1. Configure below in `main.tf` within the vpc_network folder.

   ```hcl
   module "vpc_network" {
     source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_network"

     name         = "pl-example"
     project      = var.project
     network_tier = "STANDARD"
   }
   ```

### Configuring private service access

1. Configure below in `main.tf` file within the vpc_network folder.

   ```hcl
   module "vpc_network" {
     source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_network"

     name                          = "pl-example"
     project                       = var.project
     private_service_access        = true

     private_service_access_ranges = local.private_service_access_ranges
   }
   ```

2. Within the vpc_network folder create a private_service_access_ranges.tf file and list PSC endpoints in it as shown at [the example private_service_access_ranges.tf](https://github.com/pcln/terraform-gcp-net_vpc_network/blob/master/examples/vpc_network/private_service_access_ranges.tf)

### Configuring private service connect

1. Configure below in `main.tf` within the vpc_network folder.

   ```hcl
   module "vpc_network" {
     source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_network"

     name                              = "pl-example"
     project                           = var.project
     private_service_connect           = true

     private_service_connect_endpoints = local.private_service_connect_endpoints
   }
   ```

2. Within the vpc_network folder create a private_service_connect_endpoints.tf file and list PSC endpoints in it as shown at [the example private_service_connect_endpoints.tf](https://github.com/pcln/terraform-gcp-net_vpc_network/blob/master/examples/vpc_network/private_service_connect_endpoints.tf)

### Configuring the VPC network peerings

1. Configure below in `main.tf` within the vpc_network folder.

   ```hcl
   module "vpc_network" {
     source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/vpc_network"

     name                = "pl-example"
     project             = var.project
     vpc_network_peering = true

     vpc_network_peers   = local.vpc_network_peers
   }
   ```

2. Within the vpc_network folder create a vpc_network_peers.tf file and list VPC network peers in it as shown at [the example vpc_network_peers.tf](https://github.com/pcln/terraform-gcp-net_vpc_network/blob/master/examples/vpc_network/vpc_network_peers.tf)

### Configuring the network project as shared vpc host and its service projects

Below example configures pcln-pl-net-example project as shared vpc host project.

1. Create below folder stucture within the project directory.

   ```bash
   pcln-pl-net-example
   └── network
       └── pl-example
           └── global
               └── shared_vpc
   ```

2. Configure below in `main.tf` within the vpc_network folder.

   ```hcl
   module "shared_vpc" {
     source = "git::https://github.com/pcln/terraform-gcp-net_vpc_network.git//modules/shared_vpc"

     project                     = var.project
     shared_vpc_host             = true

     shared_vpc_service_projects = local.shared_vpc_service_projects
   }
   ```

3. Within the shared_vpc folder create a shared_vpc_service_projects.tf file and list service projects in it as shown at [the example shared_vpc_service_projects.tf](https://github.com/pcln/terraform-gcp-net_vpc_network/blob/master/examples/shared_vpc/shared_vpc_service_projects.tf)

4. If this is a new project request clouddev team to create project directory and jenkins jobs for new workspaces. Define env, project, provider, variables, and versions within the project workspace.

## Provider Resources & References Used

- For VPC network
  - [google_compute_network](https://www.terraform.io/docs/providers/google/r/compute_network.html)
- For project default network tier
  - [google_compute_project_default_network_tier](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_default_network_tier)
- For private service access
  - [google_compute_global_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address)
  - [google_service_networking_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection)
  - [terraform-google-modules/private service access](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/private_service_access)
- For private service connect
  - [google_compute_global_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address)
  - [google_compute_global_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule)
- For VPC network peering
  - [google_compute_network_peering](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering)
- For shared VPC host and service projects
  - [google_compute_shared_vpc_host_project](https://www.terraform.io/docs/providers/google/r/compute_shared_vpc_host_project.html)
  - [google_compute_shared_vpc_service_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_service_project)

## Dependencies

- Provider Resource(s) mentioned above.
- [terraform_gcp_net_varlib module](https://github.com/pcln/terraform-gcp-net_varlib/browse)
- Workspace environment and project input.
- Project Service Accounts.

<!-- BEGIN_TF_DOCS -->
#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.private_service_connect](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_compute_global_forwarding_rule.private_service_connect](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_forwarding_rule) | resource |
| [google_compute_global_address.private_service_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_network_peering.peer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering) | resource |
| [google_compute_project_default_network_tier.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_default_network_tier) | resource |
| [google_service_networking_connection.private_service_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input_name) | The name of the network being created | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input_project) | Project ID | `string` | n/a | yes |
| <a name="input_auto_create_subnetworks"></a> [auto_create_subnetworks](#input_auto_create_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| <a name="input_delete_default_routes_on_create"></a> [delete_default_routes_on_create](#input_delete_default_routes_on_create) | If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input_description) | An optional description of the network. The resource must be recreated to modify this field. | `string` | `""` | no |
| <a name="input_mtu"></a> [mtu](#input_mtu) | The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically. | `number` | `0` | no |
| <a name="input_network_tier"></a> [network_tier](#input_network_tier) | The default network tier to be configured for the project. This field can take the following values: PREMIUM or STANDARD. | `string` | `"PREMIUM"` | no |
| <a name="input_private_service_access"></a> [private_service_access](#input_private_service_access) | Creates private service access ranges if set to 'true' | `bool` | `false` | no |
| <a name="input_private_service_access_ranges"></a> [private_service_access_ranges](#input_private_service_access_ranges) | private_service_access range definitions. | <pre>map(object({<br>    address       = string<br>    prefix_length = number<br>    # ip_version = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_private_service_connect"></a> [private_service_connect](#input_private_service_connect) | Creates private service connect endpoints if set to 'true' | `bool` | `false` | no |
| <a name="input_private_service_connect_endpoints"></a> [private_service_connect_endpoints](#input_private_service_connect_endpoints) | private_service_connect endpoint definitions. | <pre>map(object({<br>    address = string<br>    target  = string<br>  }))</pre> | `{}` | no |
| <a name="input_routing_mode"></a> [routing_mode](#input_routing_mode) | The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are REGIONAL and GLOBAL. | `string` | `"GLOBAL"` | no |
| <a name="input_vpc_network_peering"></a> [vpc_network_peering](#input_vpc_network_peering) | Creates vpc network peers if set to 'true' | `bool` | `false` | no |
| <a name="input_vpc_network_peers"></a> [vpc_network_peers](#input_vpc_network_peers) | vpc network peer definitions. | <pre>map(object({<br>    peer_project_name                   = string<br>    peer_vpc_network_name               = string<br>    export_custom_routes                = bool<br>    import_custom_routes                = bool<br>    export_subnet_routes_with_public_ip = bool<br>    import_subnet_routes_with_public_ip = bool<br>  }))</pre> | `{}` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_ipv4"></a> [gateway_ipv4](#output_gateway_ipv4) | The gateway address for default routing out of the network. This value is selected by GCP. |
| <a name="output_id"></a> [id](#output_id) | VPC network identifier with format projects/{{project}}/global/networks/{{name}} |
| <a name="output_network_self_link"></a> [network_self_link](#output_network_self_link) | The URI of the created VPC network. |
<!-- END_TF_DOCS -->
