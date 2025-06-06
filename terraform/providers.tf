## Estou utilizando um backend para salvar o tfstate dentro de um s3
## O perfil utilizado possui permissão somente no s3 em questão
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-741916656380"
    key     = "dev/Infra-Challenge-20240202-Coodesh/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "iam-backend"
  }
}

## O perfil utilizado é administrador e validado via SSO
provider "aws" {

  region  = "us-east-1"
  profile = "sso-lucasfegueredo"

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
      terraform   = "true"
    }
  }
}