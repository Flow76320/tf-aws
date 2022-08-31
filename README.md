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


<!-- BEGIN_TF_DOCS -->
---
Following documentation is generated with [terraform-docs](https://terraform-docs.io).


## Requirements

No requirements.
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cidr_block"></a> [eks\_cidr\_block](#input\_eks\_cidr\_block) | EKS network in CIDR notation | `string` | `"10.0.1.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-3"` | no |
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