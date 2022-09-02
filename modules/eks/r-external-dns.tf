## External-DNS controller
## Installation link https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md

# DNS registration is managed by External-DNS service
## Public DNS zone
resource "aws_route53_zone" "dns_zone" {
  name = var.dns_zone_name

  tags = local.tags
}

## Private DNS zone
# resource "aws_route53_zone" "private_dns_zone" {
#   name = var.dns_zone_name

#   vpc {
#     vpc_id = var.eks_vpc_id
#   }

#   tags = local.tags
# }

### Policies
resource "aws_iam_policy" "aws_external_dns_controller_policy" {
  name = "AllowExternalDNSUpdates"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "route53:ChangeResourceRecordSets"
          ],
          "Resource" : [
            "arn:aws:route53:::hostedzone/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets"
          ],
          "Resource" : [
            "*"
          ]
        }
      ]
    }
  )
  description = "External DNS Controller add-on for EKS"
}

# /!\ Only for testing env because this will assign allow read-write access to all pods running on the same node pool, not just the ExternalDNS pod(s)
resource "aws_iam_role_policy_attachment" "aws_external_dns_controller_policy_attachment_workers" {
  role       = aws_iam_role.eks_iam_role_workers.name
  policy_arn = aws_iam_policy.aws_external_dns_controller_policy.arn
}

### Add-on installation
resource "helm_release" "aws_external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  namespace         = "kube-system"
  dependency_update = true
  create_namespace  = false
  timeout           = 300

  set {
    name  = "provider"
    value = "aws"
  }
  set {
    name  = "domainFilters[0]"
    value = var.dns_zone_name
  }
  set {
    name  = "policy"
    value = "sync"
  }
  set {
    name  = "registry"
    value = "txt"
  }
  set {
    name  = "txtOwnerId"
    value = aws_route53_zone.dns_zone.id
  }
  set {
    name  = "interval"
    value = "3m"
  }

  depends_on = [
    aws_iam_role_policy_attachment.aws_external_dns_controller_policy_attachment_workers
  ]
}
