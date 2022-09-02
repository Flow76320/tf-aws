# Pypi server & ML Hub

This repository demonstrates how to install a Pypi Server and ML Hub on EKS, with Terraform.

In order to test, we'll build a simple Python package and retrieve it from a ML Hub Jupyter notebook.

## Requirements

* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [AWS credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
* [Helm installed](https://helm.sh/docs/intro/quickstart/)
* Unzip package
* Python 3.6

## Credentials
Once AWS CLI is installed, you need to create an IAM account to allow Terraform to work with AWS APIs.
From AWS UI:
- Create an IAM user
- Give it sufficient rights to manage VPC, Route53, Load balancers, EC2 and EKS
- Run `aws configure` and enter the account credentials. The command will create ~/.aws/config and ~/.aws/credentials files.
> **_NOTE:_** You can check that your credentials are functional by running `aws sts get-caller-identity`.

## Infrastructure creation
To install this projet, clone this repository.
You can update AWS configuration if you want to by updating `providers.tf` file
```
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"

  region = var.region
}
```
and update the infrastructure variables in `eks.auto.tfvars`. There are only few variables to override for this demonstration.

Next, run:
```
cd tf-aws
terraform plan -out=/tmp/awsplan
# Check the plan. If it suits to you
terraform apply /tmp/awsplan
```

## Check access to the EKS cluster
Once Terraform has finished, you can retrieve an EKS token and connect to it with
``` 
aws eks get-token
aws eks update-kubeconfig --region region-code --name cluster-name --kubeconfig kubeconfig_path
```

## Charts installed
In this demonstration, the Helm Charts used are:
* pypiserver from https://owkin.github.io/charts in version 3.1.1
- mlhub master version from https://github.com/ml-tooling/ml-hub/archive/refs/heads/master.zip. This Chart is built locally during the Terraform run

## Login to MLHub
Terraform code creates a public Route53 but no public DNS domain is configured in front of the default domain "test.test". Thus, you need to configure your `/etc/hosts` to add the public IP of the DNS entry `mlhub.test.test` to be able to get the UI.

Default login procedure is provided [here](https://github.com/ml-tooling/ml-hub#configuration). First, register `admin` user with a password; then login with the previous credentials.

## How to use Pypi server
The same way as MLHub, Pypi server's public IP (Load balancer public IP) needs to be retrieved from AWS Route53 menu and added to your `/etc/hosts`.
The default public URL for this demonstration is `pypiserver.test.test`.

### Build the Python package
A simple Python package is present into `python` folder to demonstrate how to push/pull to/from the Pypi server.

This section is based on https://packaging.python.org/en/latest/tutorials/packaging-projects/.

To build the package, run:
```
cd python
python3 -m pip install --upgrade build
python3 -m build
```

The output must end with `Successfully built addition-0.0.1.tar.gz and addition-0.0.1-py3-none-any.whl`.

### Push the Python package to the Pypi server
In order to push the package to the Pypi server, we'll use [twine](https://pypi.org/project/twine/).

First of all, install twine with `python3 -m pip install --upgrade twine`.
Then, configure it with the Pypi server credentials:
```
cat <<EOF >> ~/.pypirc
[distutils]
index-servers =
    pypiserver

[pypiserver]
repository = http://pypiserver.${configured_domain}
username = ${pypi_username_from_terraform}
password = ${pypi_password_from_terraform}
EOF
```

> * **configured_domain** is test.test by default, unless you overrided `dns_zone_name` Terraform variable
>* **pypi_username_from_terraform** comes from Terraform output.
>* **pypi_password_from_terraform** comes from `terraform output pypi_server_password`

Finally, upload the package: `python3 -m twine upload --repository pypiserver dist/* --verbose`.

The output must look like:
```
INFO     Using configuration from ~/.pypirc                                                                                                                                                                                  
Uploading distributions to http://pypiserver.test.test
INFO     dist/addition-0.0.1-py3-none-any.whl (2.9 KB)                                                                                                                                                                                  
INFO     dist/addition-0.0.1.tar.gz (2.0 KB)                                                                                                                                                                                            
INFO     username set from config file                                                                                                                                                                                                  
INFO     password set from config file                                                                                                                                                                                                  
INFO     username: pypi                                                                                                                                                                                                                 
INFO     password: <hidden>                                                                                                                                                                                                             
Uploading addition-0.0.1-py3-none-any.whl
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.1/7.1 kB • 00:00 • ?
INFO     Response from http://pypiserver.test.test/:                                                                                                                                                                                    
         200 OK                                                                                                                                                                                                                         
Uploading addition-0.0.1.tar.gz
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.2/6.2 kB • 00:00 • ?
INFO     Response from http://pypiserver.test.test/:                                                                                                                                                                                    
         200 OK   
```

### Pull the package from Pypi server
#### From your local computer
/!\ Beware about DNS resolution has stated before.

Locally, you can install the package by running:

`python3 -m pip install --extra-index-url http://pypiserver.test.test/simple/ --trusted-host pypiserver.test.test addition==0.0.1`

#### From Jupyter notebook in ML Hub
Open a new Python3 file. In the first cell, add and run
```
import sys
!{sys.executable} -m pip install --extra-index-url http://pypi-pypiserver.pypi.svc:8080/simple/ --trusted-host pypi-pypiserver.pypi.svc addition==0.0.1
```

In a second cell, check that your number has been incremented!
```
from addition import addition
addition.add_one(9)
```

## Improvements
There are a lot of possible improvements to this code. Among them:

* Service K8S URL is used in Jupyter to reach Pypi server (http://pypi-pypiserver.pypi.svc/). We can improve this internal DNS resolution.
* Add cert-manager with public DNS zone to allow certificate generation from Let's Encrypt, and AWS services.
* Add CI to check Terraform format and validate modules.
* Add CI to do the testings (package build, push and pull etc.).
* Terraform destroy contains an error because DNS entries created automatically by external-dns are not removed before Terraform tries to remove the Route53 public zone.
* Add external log of applications and EKS control plane (AWS solution, filebeat pushing to ELK etc.).
* Add monitoring to EKS cluster with [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) for example.
* ...

## Other useful links:
- [AWS service endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html)

## Disclaimer
EKS installation is based on [AWS provider example](https://github.com/hashicorp/terraform-provider-aws/blob/main/examples/eks-getting-started). The [official AWS module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) has not been used for this demonstration because the goal is to show my Terraform skills, and a big part of parameters are not necessary for this use case.

For the demonstration, Pypiserver is exposed behind an ALB with DNS entries registered into Route53 DNS zone. MLhub keeps it default configuration with a simple Service of type "LoadBalancer" in order to be reached.

HTTPS has not been configured for the public endpoints. We could have used cert-manager with a public DNS zone to do Let's Encrypt DNS challenge.

There exists a permanent drift on `terraform plan` because of MLHub master branch ZIP download to build the Helm Chart if the branch master changed. It should not appear with a dedicated CI to build the package outside of Terraform. This will imply a contrainer/Helm Chart registry though.

Terraform docs is buggy regarding "providers" section (https://github.com/terraform-docs/terraform-docs/issues/530).

<!-- BEGIN_TF_DOCS -->
---
Following documentation is generated with [terraform-docs](https://terraform-docs.io).


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.28 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.6.0 |
| <a name="requirement_htpasswd"></a> [htpasswd](#requirement\_htpasswd) | 1.0.3 |
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
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS zone to register all required entries | `string` | `"test.test"` | no |
| <a name="input_eks_cidr_block_primary"></a> [eks\_cidr\_block\_primary](#input\_eks\_cidr\_block\_primary) | EKS primary network in CIDR notation | `string` | `"10.0.1.0/24"` | no |
| <a name="input_eks_cidr_block_secondary"></a> [eks\_cidr\_block\_secondary](#input\_eks\_cidr\_block\_secondary) | EKS secondary network in CIDR notation | `string` | `"10.0.2.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to set to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC network in CIDR notation | `string` | `"10.0.0.0/16"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pypi_server_password"></a> [pypi\_server\_password](#output\_pypi\_server\_password) | Pypi server password |
| <a name="output_pypi_server_username"></a> [pypi\_server\_username](#output\_pypi\_server\_username) | Pypi server username |

<!-- END_TF_DOCS -->