################################
#         Common tags          #
################################

variable "region" {
  description = "Região da AWS onde os recursos serão provisionados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Nome do projeto"
  type        = string
  default     = "Infra-Challenge-20240202-Coodesh"
}

################################
#             EC2              #
################################

variable "key_name" {
  description = "Nome da chave SSH provisionada previamente na AWS"
  type        = string
  default     = "challenge_coodesh"
}