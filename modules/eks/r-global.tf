# String used to avoid EKS name collision
resource "random_string" "suffix" {
  length  = 8
  special = false
}
