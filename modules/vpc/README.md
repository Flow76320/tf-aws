# VPC module

This submodule provides a very simple VPC with Internet access to the EKS cluster.

<!-- BEGIN_TF_DOCS -->
---
Following documentation is generated with [terraform-docs](https://terraform-docs.io).


## Requirements

No requirements.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.vpc_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.vpc_default_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | A boolean flag to enable/disable DNS hostnames in the VPC | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | A boolean flag to enable/disable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | Tenancy option for instances launched into the VPC to ensure they are run either on EC2 tenancy or a dedicated one | `string` | `"default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to set to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC network in CIDR notation | `string` | `"10.0.0.0/16"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | VPN ARN |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | Default route table ID |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |

<!-- END_TF_DOCS -->