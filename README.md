# Pypi server & ML Hub

## Requirements

* AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* AWS credentials (https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
* Helm installed ()
* Unzip package

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

## Charts installed
Pypi Server
MLHub


## Login to ML
Default login informations are provided [here](https://github.com/ml-tooling/ml-hub#configuration). First, register `admin` user with a password if not configured; then login with the previous credentials.

## How to use Pypi server
### Build the Python package
A simple Python package is present into `python` folder to demonstrate how to push/pull to/from the Pypi server.
To build the package, run:
```
cd python
python3 -m pip install --upgrade build
python3 -m build
```
The output must end with `Successfully built addition-0.0.1.tar.gz and addition-0.0.1-py3-none-any.whl`.

### Push
In order to push the package to the Pypi server, run:
#### Install Twine utility

We'll use twine to upload the Python package: `python3 -m pip install --upgrade twine`.
Then, configure it with the credentials:
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

You can check that the package has successfully been uploaded with `

### Pull
From local computer:
`python3 -m pip install --extra-index-url http://pypiserver.test.test/simple/ --trusted-host pypiserver.test.test addition==0.0.1`

From Jupyter:
* On a new Python3 file
* In the first cell, run
```
import sys
!{sys.executable} -m pip install --extra-index-url http://pypi-pypiserver.pypi.svc:8080/simple/ --trusted-host pypi-pypiserver.pypi.svc addition==0.0.1
```
* In a second cell, check your number has been incremented !
```
from addition import addition
addition.add_one(9)
```

## Improvements
Here is a list of possible improvements:

* http://pypi-pypiserver.pypi.svc/ --> URL with ingress
* Add cert-manager with public DNS zone to allow certificate generation
* Improve DNS resolution into EKS cluster, between pods
* Add CI to check Terraform format and validate modules
* Add CI to do the testings (package build, push and pull)

## Disclaimer
EKS installation is based on [AWS provider example](https://github.com/hashicorp/terraform-provider-aws/blob/main/examples/eks-getting-started)
For the demonstration, Pypiserver is exposed behind an ALB with DNS entries registered into Route53 DNS zone. MLhub keeps it default configuration with a Service of type "LoadBalancer" to be reached
HTTPS has not been configured for the public endpoints We could have used cert-manager with a public DNS zone to do Let's Encrypt DNS challenge.
Permanent drift on `terraform plan` because of MLHub master branch ZIP download.


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