# variables.tf
variable "resource_group_name" {
  type        = string
  default     = "devops-microservices-rg"
}

variable "location" {
  type        = string
  default     = "East US"
}

variable "vnet_cidr" {
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.1.1.0/24"
}

variable "cluster_name" {
  type        = string
  default     = "microservices-aks-cluster"
}

variable "node_count" {
  type        = number
  default     = 2
}

variable "node_size" {
  type        = string
  default     = "Standard_DS2_v2"
}
