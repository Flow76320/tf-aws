# Pypi server & ML Hub

## Requirements

* AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* AWS credentials (https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)

## Credentials creation
Example using IAM account
- Create an IAM user
- Give it rights (Admin here, but do not do that)
- Run `aws configure` and enter account credentials. The command will create ~/.aws/config and ~/.aws/credentials.
NOTE: you can check your credentials are functional by running `aws sts get-caller-identity`.

Useful links:
- https://docs.aws.amazon.com/general/latest/gr/rande.html (AWS service endpoints)


## Check access to the EKS cluster
`aws eks get-token`
Connect to EKS cluster `aws eks update-kubeconfig --region region-code --name cluster-name --kubeconfig kubeconfig_path`

## Disclaimer
EKS installation is based on [AWS provider example](https://github.com/hashicorp/terraform-provider-aws/blob/main/examples/eks-getting-started)


<!-- BEGIN_TF_DOCS -->
---
Following documentation is generated with [terraform-docs](https://terraform-docs.io).


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.28 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.6.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.1 |
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_helm"></a> [helm](#module\_helm) | ./modules/helm | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cidr_block_primary"></a> [eks\_cidr\_block\_primary](#input\_eks\_cidr\_block\_primary) | EKS primary network in CIDR notation | `string` | `"10.0.1.0/24"` | no |
| <a name="input_eks_cidr_block_secondary"></a> [eks\_cidr\_block\_secondary](#input\_eks\_cidr\_block\_secondary) | EKS secondary network in CIDR notation | `string` | `"10.0.2.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to set to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC network in CIDR notation | `string` | `"10.0.0.0/16"` | no |
## Outputs

No outputs.


# States backend
```
# terraform {
#   backend "remote" {
#     organization = "fganee"

#     workspaces {
#       name = "aws"
#     }
#   }
# }
```
<!-- END_TF_DOCS -->