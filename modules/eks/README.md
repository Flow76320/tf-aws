# EKS module

This module creates an EKS cluster with the following add-ons:
* ALB (Application Load balancer) to expose publicly the ingresses.
* External-DNS used to register the DNS entries

<!-- BEGIN_TF_DOCS -->
---
Following documentation is generated with [terraform-docs](https://terraform-docs.io).


## Requirements

No requirements.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.eks_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_policy.aws_external_dns_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_load_balancer_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_iam_role_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_iam_role_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_external_dns_controller_policy_attachment_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_load_balancer_controller_policy_attachment_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_iam_role_policy_attachments_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_iam_role_policy_attachments_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route_table_association.vpc_default_route_table_association_primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.vpc_default_route_table_association_secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.eks_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_sg_rule_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.eks_subnet_primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.eks_subnet_secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [helm_release.aws_external_dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.aws_lb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy.eks_iam_policy_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_iam_policy_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [http_http.aws_lb_controller_policy](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS zone to register all required entries | `string` | `"test.test"` | no |
| <a name="input_eks_cidr_block_primary"></a> [eks\_cidr\_block\_primary](#input\_eks\_cidr\_block\_primary) | EKS primary network in CIDR notation | `string` | `"10.0.1.0/24"` | no |
| <a name="input_eks_cidr_block_secondary"></a> [eks\_cidr\_block\_secondary](#input\_eks\_cidr\_block\_secondary) | EKS secondary network in CIDR notation | `string` | `"10.0.2.0/24"` | no |
| <a name="input_eks_vpc_id"></a> [eks\_vpc\_id](#input\_eks\_vpc\_id) | EKS VPC ID where EKS subnets will be created | `string` | n/a | yes |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | Whether the Amazon EKS private API server endpoint is enabled | `bool` | `false` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | Whether the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to set to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#input\_vpc\_default\_route\_table\_id) | Default route table ID for the input VPC | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | EKS cluster ARN |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | EKS cluster ID |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes Cluster Name |
| <a name="output_dns_domain"></a> [dns\_domain](#output\_dns\_domain) | DNS domain configured for External-DNS |
| <a name="output_eks_kubeconfig_certificate_authority_data"></a> [eks\_kubeconfig\_certificate\_authority\_data](#output\_eks\_kubeconfig\_certificate\_authority\_data) | EKS certificate authority data |
| <a name="output_region"></a> [region](#output\_region) | Input AWS region |

<!-- END_TF_DOCS -->