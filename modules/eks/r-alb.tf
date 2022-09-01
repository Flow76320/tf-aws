## Load balancer controller
## Installation link https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
### Policies
resource "aws_iam_policy" "aws_load_balancer_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  policy      = tostring(data.http.aws_lb_controller_policy.body)
  description = "Load Balancer Controller add-on for EKS"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_policy_attachment_workers" {
  role       = aws_iam_role.eks_iam_role_workers.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller_policy.arn
}

### Add-on installation
resource "helm_release" "aws_lb" {
  name       = "aws-alb"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.4"

  namespace         = "kube-system"
  dependency_update = true
  create_namespace  = false
  timeout           = 300

  set {
    name  = "clusterName"
    value = aws_eks_cluster.eks_cluster.name
  }
  # set {
  #   name  = "serviceAccount.create" # Uncomment if using IAM for ServiceAccount
  #   value = "false"
  # }
  # set {
  #   name  = "serviceAccount.name" # Uncomment if using IAM for ServiceAccount
  #   value = "aws-load-balancer-controller " 
  # }

}
