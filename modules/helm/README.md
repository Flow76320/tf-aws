# Helm module

This module creates all requirements for Pypi server and MLHub Helm Charts, the latter being built here.

It also managed their installation on an input EKS cluster.

<!-- BEGIN_TF_DOCS -->
---
Following documentation is generated with [terraform-docs](https://terraform-docs.io).


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_htpasswd"></a> [htpasswd](#requirement\_htpasswd) | 1.0.3 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_htpasswd"></a> [htpasswd](#provider\_htpasswd) | 1.0.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [helm_release.mlhub](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.pypi_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [htpasswd_password.hash_pypi_password](https://registry.terraform.io/providers/loafoe/htpasswd/1.0.3/docs/resources/password) | resource |
| [kubernetes_namespace.mlhub_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.pypi_server_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.pypi_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [null_resource.download_archive](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.mlhub_package_helm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.pypi_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.salt](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [local_file.mlhub_archive](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | DNS domain to register all required entries | `string` | `"test.test"` | no |
| <a name="input_mlhub_namespace"></a> [mlhub\_namespace](#input\_mlhub\_namespace) | MLHub namespace | `string` | `"mlhub"` | no |
| <a name="input_pypi_server_namespace"></a> [pypi\_server\_namespace](#input\_pypi\_server\_namespace) | Pypi server namespace | `string` | `"pypi"` | no |
| <a name="input_pypi_username"></a> [pypi\_username](#input\_pypi\_username) | Pypi server username for basic auth | `string` | `"pypi"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pypi_server_password"></a> [pypi\_server\_password](#output\_pypi\_server\_password) | Pypi server password |
| <a name="output_pypi_server_username"></a> [pypi\_server\_username](#output\_pypi\_server\_username) | Pypi server username |

<!-- END_TF_DOCS -->