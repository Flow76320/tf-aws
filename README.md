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