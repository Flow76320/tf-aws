terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }

  required_version = "~> 1.1"

}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"

  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_kubeconfig_certificate_authority_data)
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_kubeconfig_certificate_authority_data)
  }
}
