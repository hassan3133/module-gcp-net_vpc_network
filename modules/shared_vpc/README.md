<!-- BEGIN_TF_DOCS -->
#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [google_compute_shared_vpc_host_project.host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_host_project) | resource |
| [google_compute_shared_vpc_service_project.service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_service_project) | resource |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input_project) | Project ID required by google_compute_shared_vpc_host_project resource | `string` | n/a | yes |
| <a name="input_shared_vpc_host"></a> [shared_vpc_host](#input_shared_vpc_host) | Makes this project a Shared VPC host if 'true' | `bool` | `false` | no |
| <a name="input_shared_vpc_service_projects"></a> [shared_vpc_service_projects](#input_shared_vpc_service_projects) | shared_vpc_service_project definitions | `set(string)` | `[]` | no |

#### Outputs

No outputs.
<!-- END_TF_DOCS -->
